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
  
  The script will build the programs with all the combinations of `-prof` `-O` `-O2`, so that the
  effect of optimizations and the influence of profiling were exposed.

* Some `stack.yaml` configurations for various GHC versions.
  
  The suggestion here is to create a copy of the repository for each `stack.*.yaml` and separately
  explore the execution, so that differences between the way different GHC versions compile,
  optimize and profile were exposed.

  TODO: Why not run everything from one place, simply giving `stack` different `yaml` files via
  `--stack-yaml`?

TODO: Add Criterion to the mix for a more accurate time report.
