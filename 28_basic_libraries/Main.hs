module Main where

import Criterion.Main

infixl 9 !? --the l in infixl means left associative, the 9 is a precedence
(!?) :: [a] -> Int -> Maybe a --this line dramatically improves performance when benchmarking
_        !? n | n < 0 = Nothing
[]       !? _         = Nothing
(x:_)    !? 0         = Just x
(_:xs)   !? n         = xs !? (n-1)

myList :: [Int]
myList = [1..9999]

sumInts :: [Int] -> Int
sumInts = foldr (+) 0

sumIntegers :: [Integer] -> Integer
sumIntegers = foldr (+) 0

main :: IO ()
main = defaultMain
  [ bench "index list 9999"
    $ whnf (myList !!) 9998
  , bench "index list maybe index 9999"
    $ whnf (myList !?) 9998
  , bench "sum Ints"
    $ nf sumInts ([1 .. 1000] :: [Int])
  , bench "sum Integers"
    $ nf sumIntegers ([1 .. 1000] :: [Integer])
  ]