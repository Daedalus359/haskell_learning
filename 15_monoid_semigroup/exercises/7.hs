import Test.QuickCheck
import Data.Semigroup

newtype BoolDisj = BoolDisj Bool
 deriving (Show, Eq)

bCGen :: Gen BoolDisj
bCGen = do
  b <- (arbitrary :: Gen Bool)
  return (BoolDisj b)

instance Arbitrary BoolDisj where
  arbitrary = bCGen

instance Semigroup BoolDisj where
  (BoolDisj b1) <> (BoolDisj b2) = BoolDisj (b1 || b2)

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

type TestBC = BoolDisj -> BoolDisj -> BoolDisj -> Bool

main :: IO ()
main = quickCheck (semigroupAssoc :: TestBC) 
