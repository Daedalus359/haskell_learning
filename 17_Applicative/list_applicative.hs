import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

--ZipList import
import Control.Applicative

--Exercise: Implement Applicative for List
--notes: did not use the fold, concat', or flatMap functions provided as hints
  --no idea what those were meant to be for

data List a =
    Nil
  | Cons a (List a)
  deriving (Eq, Show)

append :: List a -> List a -> List a
append xs Nil = xs
append (Cons a as) blist@(Cons b bs) = Cons a $ append as blist
append Nil xs = xs

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons x xs) = Cons (f x) (fmap f xs)

instance Applicative List where
  pure a = Cons a Nil
  Nil <*> _ = Nil
  Cons f fs <*> xs = append (fmap f xs) (fs <*> xs)

--copied from larrybotha/haskell-book on github
instance Arbitrary a => Arbitrary (List a) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [Cons a (Cons b Nil), Nil]

instance Eq a => EqProp (List a) where
  (=-=) = eq

--Exercise 2:

--orphan instance of Semigroup
instance Semigroup a => Semigroup (ZipList a) where
  (<>) = liftA2 (<>)

--orphan instance of Monoid for ZipList
instance Monoid a => Monoid (ZipList a) where
  mempty = pure mempty
  mappend = liftA2 mappend

main :: IO ()
main = quickBatch (applicative (Cons ('a', 'a', 'a') Nil))
  --example type to let ghc infer the type List (Char, Char, Char)
