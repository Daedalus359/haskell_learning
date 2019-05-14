module MonadExs where

import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

--1
data Nope a = NopeDotJpg

instance Functor Nope where
  fmap _ _ = NopeDotJpg