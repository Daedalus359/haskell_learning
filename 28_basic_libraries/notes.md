# Basic Libraries

Agenda

* learn how to evaluate the data structures you have selected in your code
* measure how much time and space isused by a program
* tips for benchmarking code

### Benchmarking with Criterion

bench :: String -> Benchmarkable -> Benchmark
whnf :: (a -> b) -> a -> Benchmarkable
nf :: Control.DeepSeq.NFData b => (a -> b) -> a -> Benchmarkable

module Main where

import Criterion.Main

main :: IO ()
main = defaultMain
  [ bench "index list 9999" $ whnf myFunc 9998 ] --where myFunc is the function you want to benchmark