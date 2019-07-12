module ReaderT where

newtype ReaderT r m a =
  ReaderT {runReaderT :: r -> m a}

instance Functor m => Functor (ReaderT r m) where
  fmap f2 (ReaderT f1) = ReaderT $ (fmap . fmap) f2 f1

instance Applicative m => Applicative (ReaderT r m) where
  pure a = ReaderT $ (fmap pure) $ const a
  f <*> a = ReaderT $ (fmap (<*>) $ runReaderT f) <*> (runReaderT a)
  --notes while writing (<*>):
  --runReaderT f :: ((->) r) m (a -> b)
  --runReaderT a :: ((->) r) m (a)
  --(fmap (<*>) $ runReaderT f) :: r -> m a -> f b

--again, not yet clear how this desugars
instance Monad m => Monad (ReaderT r m) where
  return = pure
  (ReaderT rma) >>= f =
    ReaderT $ \r -> do
      a <- rma r --rma r :: m a, a :: a
      runReaderT (f a) r--f a :: a -> ReaderT r m b, RunReaderT (f a) = r -> m b, r gets wrapped up looking back before the do notation

  --(ReaderT frma) >>= aToRmb = fmap (>>= (runReaderT . aToRmb)) frma
  --frma :: r -> m a
  --aToRmb :: a -> ReaderT r m b
  --runReaderT :: ReaderT r m b -> r -> m b
  --(runReaderT . aToRmb) :: a -> r -> m b
  --(>>= (runReaderT . aToRmb)) :: 

--let frma :: Monad m => r -> m a; frma = undefined
--let aToRmb :: Monad m => a -> ReaderT r m b; aToRmb = undefined