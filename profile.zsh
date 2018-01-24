#!/bin/zsh -e

if [ ! -d prof-results ]
then

    mkdir -p prof-results/{SumNaive,SumSeq,SumPseq}

    # Stage 0: No profiling.
    # ----------------------

    # Run without optimization.

    for file in SumNaive.hs SumPseq.hs SumSeq.hs 
    do
        stack ghc                \
            --package parallel   \
            --                   \
            $file                \
            -main-is ${file%.hs} \
            -o ${file%.hs}
    done

    for file in SumNaive.hs SumSeq.hs SumPseq.hs
    do
        (time ./${file%.hs}) 2>${file%.hs}.time
        ./${file%.hs} 2>${file%.hs}.rts
    done

    for file in *.time *.rts
    do
        mv -v $file prof-results/${file%.*}/no-prof.none.${file##*.}
    done

    # Run with -O1.

    for file in SumNaive.hs SumPseq.hs SumSeq.hs 
    do
        stack ghc                \
            --package parallel   \
            --                   \
            $file                \
            -main-is ${file%.hs} \
            -O1                  \
            -o ${file%.hs}
    done

    for file in SumNaive.hs SumSeq.hs SumPseq.hs
    do
        (time ./${file%.hs}) 2>${file%.hs}.time
        ./${file%.hs} 2>${file%.hs}.rts
    done

    for file in *.time *.rts
    do
        mv -v $file prof-results/${file%.*}/no-prof.O1.${file##*.}
    done

    # Run with -O2.

    for file in SumNaive.hs SumPseq.hs SumSeq.hs 
    do
        stack ghc                \
            --package parallel   \
            --                   \
            $file                \
            -main-is ${file%.hs} \
            -O2                  \
            -o ${file%.hs}
    done

    for file in SumNaive.hs SumSeq.hs SumPseq.hs
    do
        (time ./${file%.hs}) 2>${file%.hs}.time
        ./${file%.hs} 2>${file%.hs}.rts
    done

    for file in *.time *.rts
    do
        mv -v $file prof-results/${file%.*}/no-prof.O2.${file##*.}
    done

    # Stage 2: go profiling.
    # ----------------------

    # Run without optimization.

    for file in SumNaive.hs SumPseq.hs SumSeq.hs 
    do
        stack ghc                \
            --library-profiling  \
            --package parallel   \
            --                   \
            $file                \
            -main-is ${file%.hs} \
            -prof                \
            -o ${file%.hs}
    done

    for file in SumNaive.hs SumSeq.hs SumPseq.hs
    do
        (time ./${file%.hs} +RTS -P) 2>${file%.hs}.time
        ./${file%.hs} 2>${file%.hs}.rts
    done

    for file in *.prof *.time *.rts
    do
        mv -v $file prof-results/${file%.*}/prof.none.${file##*.}
    done

    # Run with -O1.

    for file in SumNaive.hs SumPseq.hs SumSeq.hs 
    do
        stack ghc                \
            --library-profiling  \
            --package parallel   \
            --                   \
            $file                \
            -main-is ${file%.hs} \
            -prof                \
            -O1                  \
            -o ${file%.hs}
    done

    for file in SumNaive.hs SumSeq.hs SumPseq.hs
    do
        (time ./${file%.hs} +RTS -P) 2>${file%.hs}.time
        ./${file%.hs} 2>${file%.hs}.rts
    done

    for file in *.prof *.time *.rts
    do
        mv -v $file prof-results/${file%.*}/prof.O1.${file##*.}
    done

    # Run with -O2.

    for file in SumNaive.hs SumPseq.hs SumSeq.hs 
    do
        stack ghc                \
            --library-profiling  \
            --package parallel   \
            --                   \
            $file                \
            -main-is ${file%.hs} \
            -prof                \
            -O2                  \
            -o ${file%.hs}
    done

    for file in SumNaive.hs SumSeq.hs SumPseq.hs
    do
        (time ./${file%.hs} +RTS -P) 2>${file%.hs}.time
        ./${file%.hs} 2>${file%.hs}.rts
    done

    for file in *.prof *.time *.rts
    do
        mv -v $file prof-results/${file%.*}/prof.O2.${file##*.}
    done
fi

# Stage 3: Tabulate the results.
# ------------------------------

cd prof-results

echo 'project   	optimization	no prof	prof'

for dir in */
do
    for tag in none O1 O2
    do
        echo -n "${dir%/}   	$tag     \t"
        cat $dir/no-prof.$tag.time |
            sed -r 's/.* ([0-9]+\.[0-9]+s) user .*/\1/' |
            tr -s '\n' '\t'

        cat $dir/prof.$tag.time |
            sed -r 's/.* ([0-9]+\.[0-9]+s) user .*/\1/' |
            tr -s '\n' '\t'
        echo
    done
done
