module StateT where

import Control.Applicative
import Control.Monad.Trans.Class
import Control.Monad.IO.Class

newtype StateT s m a =
  StateT {runStateT :: s -> m (a, s)}

instance Functor m => Functor (StateT s m) where
  fmap f2 (StateT f1) = StateT $ (fmap . fmap) (\(a, s) -> (f2 a, s)) f1

instance Monad m => Applicative (StateT s m) where
  pure a = StateT (\s -> pure (a, s))
  (StateT fab) <*> (StateT a) = StateT $ liftA2 wrestleTup fab a
    where
      wrestleTup :: Monad m => m (a -> b, s) -> m (a, s) -> m (b, s)
      wrestleTup mf ma = do
        (f, s1) <- mf
        (a, s2) <- ma
        return $ (f a, s2)--is getting rid of s1 problematic? Is this a lawful instance?

instance Monad m => Monad (StateT s m) where
  return = pure
  (StateT fsmas) >>= faSTsmb = StateT $ \s -> do
    (a, s') <- fsmas s --fsmas s :: m (a, s)
    (runStateT $ faSTsmb a) s
      --faSTsmb :: (a -> StateT s m b)
      --faSTsmb a :: StateT s m b
      --runStateT $ faSTsmb a :: s -> m (b, s)
      --(runStateT $ faSTsmb a) s :: m (b, s)

instance MonadTrans (StateT s) where
  lift m = StateT $ \s -> fmap (\a -> (a, s)) m

instance MonadIO m => MonadIO (StateT s m) where
  liftIO = lift . liftIO