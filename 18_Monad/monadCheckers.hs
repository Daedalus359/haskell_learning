module BadMonad where

--import Test.QuickCheck
--import Test.QuickCheck.Checkers
--import Test.QuickCheck.Classes

data CountMe a = 
  CountMe Integer a
  deriving (Eq, Show)

instance Functor CountMe where
  fmap f (CountMe i a) = (CountMe (i + 1) (f a)) -- assuming i + 1 will be an issue for identity law

instance Applicative CountMe where
  pure = CountMe 0
  (CountMe i1 fab) <*> (CountMe i2 a) = CountMe (i1 + i2) (fab a) --this seems OK to me at first glance

instance Monad CountMe where
  (CountMe i a) >>= famb =
    let CountMe _ b = famb a
    in CountMe (i + 1) b

  return = pure

--instance Arbitrary a => Arbitrary (CountMe a) where
--  arbitrary = CountMe <$> arbitrary <*> arbitrary