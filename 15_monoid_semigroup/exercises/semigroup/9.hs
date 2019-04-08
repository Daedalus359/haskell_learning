import Test.QuickCheck
import Data.Semigroup

data Combine a b = Combine {unCombine :: (a -> b)}

instance (Semigroup b) => Semigroup (Combine a b) where
  (Combine f) <> (Combine g) = Combine (\a -> ((f a) <> (g a)))

--skipping QuickCheck since it seems to require more advanced tools than I have been taught
