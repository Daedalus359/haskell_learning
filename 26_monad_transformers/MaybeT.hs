module MaybeT where

import Control.Monad.IO.Class

newtype MaybeT m a =
  MaybeT {runMaybeT :: m (Maybe a)}

instance Functor m => Functor (MaybeT m) where
  fmap f (MaybeT m) = MaybeT $ (fmap . fmap) f m

instance Applicative m => Applicative (MaybeT m) where
  pure = MaybeT . pure . Just
  (MaybeT mf) <*> (MaybeT ma) = MaybeT $ (fmap (<*>) mf) <*> ma

--desugar this!
instance (Monad m) => Monad (MaybeT m) where
  return = pure
  (MaybeT ma) >>= aToMTmb = MaybeT $ do
    v <- ma --v has type Maybe a
    case v of
      Nothing -> return Nothing--puts Nothing inside of the context of m
      Just y -> runMaybeT (aToMTmb y)

  --my notes in the attempt I maed to write this alone:
    --aToMTmb :: (a -> MaybeT m b)
    --ma :: Maybe (m a)
    --(>>=) :: (m a) -> (a -> m b) -> m b
    --fmap (>>=) ma :: Maybe ((a -> m b) -> m b)
    --pure aToMTmb :: Maybe (a -> MaybeT m b)--for Maybe's instance of pure
    --fmap runMaybeT (pure aToMTmb) :: Maybe (a -> m (Maybe b))
    --fmap (>>=) ma <*> (pure aToMTmb)

instance (MonadIO m) => MonadIO (MaybeT m) where
  liftIO = MaybeT . fmap Just . liftIO