#!/bin/zsh -e

mkdir -p prof-results

# Stage 0: No profiling.
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
        -o ${file%.hs}
done

for file in SumNaive.hs SumSeq.hs SumPseq.hs
do
    time ./${file%.hs} 2>${file%.hs}.time
done

for file in SumNaive.prof SumSeq.prof SumPseq.prof SumNaive.time SumSeq.time SumPseq.time
do
    cp -v $file prof-results/${file%.*}.no-prof.no-opt.${file##*.}
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
        -O1                  \
        -o ${file%.hs}
done

for file in SumNaive.hs SumSeq.hs SumPseq.hs
do
    time ./${file%.hs} 2>${file%.hs}.time
done

for file in SumNaive.prof SumSeq.prof SumPseq.prof SumNaive.time SumSeq.time SumPseq.time
do
    cp -v $file prof-results/${file%.*}.no-prof.O1.${file##*.}
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
        -O2                  \
        -o ${file%.hs}
done

for file in SumNaive.hs SumSeq.hs SumPseq.hs
do
    time ./${file%.hs} 2>${file%.hs}.time
done

for file in SumNaive.prof SumSeq.prof SumPseq.prof SumNaive.time SumSeq.time SumPseq.time
do
    cp -v $file prof-results/${file%.*}.no-prof.O2.${file##*.}
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
    time ./${file%.hs} +RTS -P 2>${file%.hs}.time
done

for file in SumNaive.prof SumSeq.prof SumPseq.prof SumNaive.time SumSeq.time SumPseq.time
do
    cp -v $file prof-results/${file%.*}.prof.no-opt.${file##*.}
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
    time ./${file%.hs} +RTS -P 2>${file%.hs}.time
done

for file in SumNaive.prof SumSeq.prof SumPseq.prof SumNaive.time SumSeq.time SumPseq.time
do
    cp -v $file prof-results/${file%.*}.prof.O1.${file##*.}
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
    time ./${file%.hs} +RTS -P 2>${file%.hs}.time
done

for file in SumNaive.prof SumSeq.prof SumPseq.prof SumNaive.time SumSeq.time SumPseq.time
do
    cp -v $file prof-results/${file%.*}.prof.O2.${file##*.}
done

