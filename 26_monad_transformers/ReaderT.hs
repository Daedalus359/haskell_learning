module ReaderT where

newtype ReaderT r m a =
  ReaderT {runReaderT :: r -> m a}

instance Functor m => Functor (ReaderT r m) where
  fmap f2 (ReaderT f1) = ReaderT $ (fmap . fmap) f2 f1