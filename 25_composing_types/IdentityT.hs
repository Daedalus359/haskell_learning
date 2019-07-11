module IdentityT where

import Data.Char --for an example I want to try

newtype IdentityT f a =
  IdentityT {runIdentityT :: f a}
  deriving (Eq, Show)

instance (Functor f) => Functor (IdentityT f) where
  fmap f (IdentityT fa) = IdentityT $ fmap f fa

instance (Applicative f) => Applicative (IdentityT f) where
  pure = IdentityT . pure
  (IdentityT fab) <*> (IdentityT fa) = IdentityT $ fab <*> fa

instance (Monad f) => Monad (IdentityT f) where
  return = pure
  (IdentityT fa) >>= aToITfb = IdentityT $ fa >>= (runIdentityT . aToITfb)
    --(>>=) :: f a -> (a -> f b) -> f b
    --runIdentity . aToITFB :: a -> f b
    --fa >>= (runIdentity . aToITFB) :: f b

ex = (IdentityT "abc") :: IdentityT [] Char