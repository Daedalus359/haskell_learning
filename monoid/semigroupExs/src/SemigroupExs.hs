module SemigroupExs where

import Data.Semigroup
import Test.QuickCheck

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

data Trivial  = Trivial deriving (Eq, Show)
instance Semigroup Trivial where
    _ <> _ = Trivial

instance Arbitrary Trivial where
    arbitrary = return Trivial

type TrivAssoc = Trivial -> Trivial -> Trivial -> Bool

newtype Identity a = Identity a
