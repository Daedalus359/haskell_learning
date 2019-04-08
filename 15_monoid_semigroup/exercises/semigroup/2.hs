import Test.QuickCheck
import Data.Semigroup

newtype Identity a = Identity a

instance (Semigroup a) => Semigroup (Identity a) where
  (Identity first) <> (Identity second) = Identity (first <> second)

instance (Eq a) => Eq (Identity a) where
  (Identity first) == (Identity second) = first == second

identityGen :: Arbitrary a => Gen (Identity a)
identityGen = do
  a <- arbitrary
  return (Identity a)

instance (Arbitrary a) => Arbitrary (Identity a) where
  arbitrary = identityGen

instance (Show a) => Show (Identity a) where
  show (Identity a) = "Identity " ++ (show a)

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

type TestAssoc a = Identity a -> Identity a -> Identity a -> Bool

main :: IO ()
main = quickCheck (semigroupAssoc :: (TestAssoc String))

