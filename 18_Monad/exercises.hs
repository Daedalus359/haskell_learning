module MonadExs where

import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes


--testProps :: Monad m => m (String, Int, String) -> IO ()--not really a valid signature, needs more quickBatch constraints
testProps aVal = do
  quickBatch $ functor aVal
  quickBatch $ applicative aVal
  quickBatch $ monad aVal

--Section 1: Monad Instances

--1
data Nope a = NopeDotJpg
  deriving (Eq, Show)

instance Functor Nope where
  fmap _ _ = NopeDotJpg

instance Applicative Nope where
  pure _ = NopeDotJpg
  _ <*> _ = NopeDotJpg

instance Monad Nope where
  _ >>= _ = NopeDotJpg

instance Arbitrary a => Arbitrary (Nope a) where
  arbitrary = pure NopeDotJpg

instance Eq a => EqProp (Nope a) where
  (=-=) = eq

test1 :: IO ()
test1 = do
  let trigger :: Nope (String, Int, String); trigger = undefined
  testProps trigger

--2
data PEither b a = --reverse Either?
    Left' a
  | Right' b
  deriving (Eq, Show)

instance Functor (PEither b) where
  fmap f (Left' a) = Left' (f a)
  fmap _ (Right' b) = Right' b

instance Applicative (PEither b) where
  pure a = Left' a
  _ <*> Right' b = Right' b
  Right' b <*> Left' _ = Right' b
  Left' fab <*> Left' a = Left' (fab a)

instance Monad (PEither b) where
  Right' b >>= f = Right' b
  Left' a >>= f = f a 

instance (Arbitrary a, Arbitrary b) => Arbitrary (PEither b a) where
  arbitrary = oneof [Left' <$> arbitrary, Right' <$> arbitrary]

instance (Eq a, Eq b) => EqProp (PEither b a) where
  (=-=) = eq

test2 :: IO ()
test2 = do
  let trigger :: PEither (Int, String, Int) (String, Int, String); trigger = undefined
  testProps trigger

--3
newtype Identity a = Identity a
  deriving (Eq, Ord, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity $ f a

instance Applicative Identity where
  pure = Identity
  Identity f <*> Identity a = Identity $ f a

instance Monad Identity where
  return = pure
  (Identity a) >>= f = f a

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = Identity <$> arbitrary

instance Eq a => EqProp (Identity a) where
  (=-=) = eq

test3 :: IO ()
test3 = do
  let trigger :: Identity (String, Int, String); trigger = undefined
  testProps trigger

--4
data List a = Nil | Cons a (List a)
  deriving (Eq, Show)

instance Functor List where
  fmap f Nil = Nil
  fmap f (Cons a lst) = Cons (f a) (fmap f lst)

listConcat :: List a -> List a -> List a
listConcat Nil lst = lst
listConcat lst Nil = lst
listConcat (Cons a lstA) lst = Cons a (listConcat lstA lst)

listListCon :: List (List a) -> List a
listListCon Nil = Nil
listListCon (Cons lst1 lsts) = listConcat lst1 (listListCon lsts)

instance Applicative List where
  pure a = Cons a Nil
  Nil <*> _ = Nil
  _ <*> Nil = Nil
  (Cons f lstF) <*> lstA = listConcat (fmap f lstA) (lstF <*> lstA)

instance Monad List where
  Nil >>= f = Nil
  lstA >>= f = listListCon (fmap f lstA)

instance Arbitrary a => Arbitrary (List a) where
  arbitrary = oneof [Cons <$> arbitrary <*> arbitrary, return Nil]--proud of coming up with this on my own

instance Eq a => EqProp (List a) where
  (=-=) = eq

test4 :: IO ()
test4 = do
  let trigger :: List (String, Int, String); trigger = undefined
  testProps trigger

--Section 2: writing functions

--1: seems to be join
j :: Monad m => m (m a) -> m a
j = (\m -> m >>= id)

--2:
l1 :: Monad m => (a -> b) -> m a -> m b
l1 = (<*>) . return

--3:
l2 :: Monad m => (a -> b -> c) -> m a -> m b -> m c
l2 f ma= (<*>) $ (<*>) (return f) ma

--4
a :: Monad m => m a -> m (a -> b) -> m b
a = flip (<*>)

--5
meh :: Monad m => [a] -> (a -> m b) -> m [b]
meh [] _ = return []
meh (x : xs) f = l2 (:) (f x) (meh xs f)

--6
flipType :: Monad m => [m a] -> m [a]
flipType lst= meh lst id

