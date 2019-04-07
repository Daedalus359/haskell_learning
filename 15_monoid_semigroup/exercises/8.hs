import Test.QuickCheck
import Data.Semigroup

data Or a b = Fst a | Snd b

instance (Semigroup a, Semigroup b) => Semigroup (Or a b) where
  (Snd a) <> _ = Snd a
  (Fst a) <> (Snd b) = Snd b
  (Fst a) <> (Fst b) = Fst b

orGen :: (Arbitrary a, Arbitrary b) => Gen (Or a b)
orGen = do
  a <- arbitrary
  b <- arbitrary
  oneof [ return $ Fst a, return $ Snd b ] -- from larrybotha on github

instance (Arbitrary a, Arbitrary b) => Arbitrary (Or a b) where
  arbitrary = orGen

instance (Show a, Show b) => Show (Or a b) where
  show (Fst a) = "Fst " ++ (show a)
  show (Snd b) = "Snd " ++ (show b)

instance (Eq a, Eq b) => Eq (Or a b) where
  (Fst _) == (Snd _) = False
  (Snd _) == (Fst _) = False
  (Fst a) == (Fst b) = a == b
  (Snd a) == (Snd b) = a == b

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

type TestAssoc a b = (Or a b) -> (Or a b) -> (Or a b) -> Bool

main :: IO ()
main = quickCheck (semigroupAssoc :: (TestAssoc String [Int]))
