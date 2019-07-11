module BifucntorInstances where

class Bifunctor p where
  {-# MINIMAL bimap | first, second #-}

  bimap :: (a -> b) -> (c -> d) -> p a c -> p b d --p :: * -> * -> *
  bimap f g = first f . second g

  first :: (a -> b) -> p a c -> p b c
  first f = bimap f id

  second :: (c -> d) -> p a c -> p a d
  second = bimap id

data Deux a b = Deux a b
  deriving Show

instance Bifunctor Deux where
  bimap f g (Deux a b) = Deux (f a) (g b)

data Const a b = Const a
  deriving Show

instance Bifunctor Const where
  bimap f g (Const a) = Const (f a)

data Drei a b c = Drei a b c
  deriving Show

instance Bifunctor (Drei a) where
  bimap f g (Drei a b c) = Drei a (f b) (g c)

data SuperDrei a b c = SuperDrei a b

instance Bifunctor (SuperDrei a) where
  bimap f g (SuperDrei a b) = SuperDrei a (f b)

data SemiDrei a b c = SemiDrei a

instance Bifunctor (SemiDrei a) where
  bimap f g (SemiDrei a) = SemiDrei a

data Qua a b c d = Qua a b c d

instance Bifunctor (Qua a b) where
  bimap f g (Qua a b c d) = Qua a b (f c) (g d)

data Eitherr a b = Leftr a | Rightr b

instance Bifunctor Eitherr where
  bimap f g (Leftr a) = Leftr (f a)
  bimap f g (Rightr b) = Rightr (g b)
