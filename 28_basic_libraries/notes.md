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

### Profiling Time Use
See ProfilingTime.hs and run

$ stack ghc -- -prof -fprof-auto -rtsopts -O2 ProfilingTime.hs

### Profiling Heap Allocation
See ProfilingSpace.hs and run

$ stack ghc -- -prof -fprof-auto -rtsopts -O2 ProfilingSpace.hs

then

$ ./ProfilingSpace +RTS -hc -p

then

stack install hp2pretty (if needed)

then

hp2pretty ProfilingSpace.hp

then open the resulting svg (via chrome, for example)

### Map (Data Structure)

data Map k a
 = Bin
   {-# UNPACK #-}
   !Size !k a
   !(Map k a) !(Map k a)
 | Tip

type Size = Int

Map is mainly used when you want lookup by key to be fast

When **not to use** Map

Using Ints as keys suggests that HashMap, IntMap, or Vector may be more appropriate

### Set (Data Structure)

data Set a
  = Bin
    {-# UNPACK #-}
    !Size !a !(Set a) !(Set a)
  | Tip

type Size = Int

basically, the difference from Map is that there is no value (in the key-value sense) assocated with each internal node of the tree

Good when you want fast membership tests

### Sequence (Data Structure)

Cheap **appends** to the front **or to the back** (unlike list)
Cheap **concatenation**
cheaper indexing for **large sequences** compared to list (list wins for smaller cases)

newtype Seq a = Seq (FingerTree (Elem a))

newtype Elem a = Elem { getEken :: a }

data FingerTree a
    = Empty
    | Single a
    | Deep {-# UNPACK #-} !Int !(Digit a) (FingerTree (Node a)) !(Digit a)

### Vector

Vectors are efficient Arrays (don't use Array, apparently)

data Vector a =
     Vector {-# UNPACK #-} !Int
            {-# UNPACK #-} !Int
            {-# UNPACK #-} !(Array a)
     deriving (Typeable)

Vector is **good** for
* extreme memory efficiency
* access via indexing by Int values
* equal access times for every element

Some optimizations allow for using the same inner-loop array over and over again without re-instantiating
the vector library / GHC handle this automatically in many cases

See chapter for examples of mutability for really fast updates

ST can be thoght of as Mutable State, or as IO restricted to safe mutation

see Lazy Functional State Threads; John Launchbury and Simon Peyton Jones

