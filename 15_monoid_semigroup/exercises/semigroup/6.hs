import Test.QuickCheck
import Data.Semigroup

newtype BoolConj = BoolConj Bool
 deriving (Show, Eq)

bCGen :: Gen BoolConj
bCGen = do
  b <- (arbitrary :: Gen Bool)
  return (BoolConj b)

instance Arbitrary BoolConj where
  arbitrary = bCGen

instance Semigroup BoolConj where
  (BoolConj b1) <> (BoolConj b2) = BoolConj (b1 && b2)

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

type TestBC = BoolConj -> BoolConj -> BoolConj -> Bool

main :: IO ()
main = quickCheck (semigroupAssoc :: TestBC) 
