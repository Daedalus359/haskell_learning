--exercise 5. Similar logic applies to exercises 3 and 4

import Test.QuickCheck
import Data.Semigroup
import qualified Data.List as DL

data Four a b c d = Four a b c d

instance (Semigroup a, Semigroup b, Semigroup c, Semigroup d) => Semigroup (Four a b c d) where
  (Four a b c d) <> (Four a' b' c' d') = Four (a <> a') (b <> b') (c <> c') (d <> d')

instance (Eq a, Eq b, Eq c, Eq d) => Eq (Four a b c d) where
  (Four a b c d) == (Four a' b' c' d') = and [(a == a'), (b == b'), (c == c'), (d == d')]

fourGen :: (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Gen (Four a b c d)
fourGen = do
  a <- arbitrary
  b <- arbitrary
  c <- arbitrary
  d <- arbitrary
  return (Four a b c d)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = fourGen

instance (Show a, Show b, Show c, Show d) => Show (Four a b c d) where
 -- show (Four a b c d) = "Four: " ++ (concat (DL.intersperse ", " (fmap show [a, b, c, d])))
  show (Four a b c d) = "Four: " ++ concat (DL.intersperse ", " [(show a), (show b), (show c), (show d)])

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

type TestAssoc a b c d = (Four a b c d) -> (Four a b c d) -> (Four a b c d) -> Bool

main :: IO ()
main = quickCheck (semigroupAssoc :: (TestAssoc String [Int] [Bool] (Either String Int)))

