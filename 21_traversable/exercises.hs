import Control.Applicative

--1
newtype Identity a = Identity a
  deriving (Eq, Ord, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance Foldable Identity where
  foldr f b (Identity a) = f a b

instance Traversable Identity where
  traverse f (Identity a) = fmap Identity (f a)

--2
newtype Constant a b = Constant {getConstant :: a}

instance Functor (Constant a) where
  fmap f (Constant a) = Constant a

instance Foldable (Constant a) where
  foldr f c (Constant a) = c

instance Traversable (Constant a) where
  traverse f (Constant a) = pure (Constant a)

--3
data Optional a = Nada | Yep a

instance Functor Optional where
  fmap _ Nada = Nada
  fmap f (Yep a) = Yep (f a)

instance Foldable Optional where
  foldr f b Nada = b
  foldr f b (Yep a) = f a b

instance Traversable Optional where
  traverse f Nada = pure Nada
  traverse f (Yep a) = fmap Yep (f a)

--4
data List a = Cons a (List a) | Nil
  deriving Show

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a lst) = Cons (f a) (fmap f lst)

instance Foldable List where
  foldr _ b Nil = b
  foldr f b (Cons a lst) = foldr f (f a b) lst

instance Traversable List where
  traverse f Nil = pure Nil
  traverse f (Cons a lst) = liftA2 Cons (f a) (traverse f lst)

--5
data Three a b c = Three a b c
  deriving Show

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

instance Foldable (Three a b) where
  foldr f d (Three a b c) = f c d

instance Traversable (Three a b) where
  traverse f (Three a b c) = fmap (Three a b) (f c)

--6
data Pair a b = Pair a b
  deriving Show

instance Functor (Pair a) where
  fmap f (Pair a b) = Pair a (f b)

instance Foldable (Pair a) where
  foldr f c (Pair a b) = f b c

instance Traversable (Pair a) where
  traverse f (Pair a b) = fmap (Pair a) (f b)

--7
data Big a b = Big a b b
  deriving Show

instance Functor (Big a) where
  fmap f (Big a b1 b2) = Big a (f b1) (f b2)

instance Foldable (Big a) where
  foldr f c (Big a b1 b2) = f b2 (f b1 c)

--instance Traversable (Big a) where
  --traverse f (Big a b b) = 