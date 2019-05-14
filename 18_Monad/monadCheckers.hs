module BadMonad where

import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

data CountMe a = 
  CountMe Integer a
  deriving (Eq, Show)

instance Functor CountMe where
  fmap f (CountMe i a) = (CountMe i (f a)) -- assuming i + 1 will be an issue for identity law

instance Applicative CountMe where
  pure = CountMe 0
  (CountMe i1 fab) <*> (CountMe i2 a) = CountMe (i1 + i2) (fab a) --this seems OK to me at first glance

instance Monad CountMe where
  (CountMe i a) >>= famb =
    let CountMe i2 b = famb a
    in CountMe (i + i2) b --works without i2 as well

  return = pure

instance Arbitrary a => Arbitrary (CountMe a) where
  arbitrary = CountMe <$> arbitrary <*> arbitrary

instance Eq a => EqProp (CountMe a) where
  (=-=) = eq

main = do
  let trigger :: CountMe (Int, String, Int); trigger = undefined -- GHC only needs the type to build the test
  quickBatch $ functor trigger
  quickBatch $ applicative trigger
  quickBatch $ monad trigger