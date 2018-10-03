module Main where

import SemigroupExs
import Test.QuickCheck

main :: IO ()
main = quickCheck (semigroupAssoc :: TrivAssoc)
