`seq` versus `pseq`
===================

*Profiling a contrived seq / pseq application.*

In this repository:

* Three `*.hs` files. It's a contrived sum program with a custom fold.
    * One is without strictness: `SumNaive`.
    * The other is with two-side-strict `seq`: `SumSeq`.
    * The third one is with left-side-strict `pseq` from `parallel`: `SumPseq`.

* A shell script that builds these programs and collects their running parameters: running time
  and RTS output, as well as some profiling data.

TODO: Add Criterion to the mix for a more accurate time report.
