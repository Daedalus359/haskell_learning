module EitherT where

import Control.Monad.Trans.Class

newtype EitherT e m a = --why does the book use e a for the type parameters instead of a b? Error type?
  EitherT {runEitherT :: m (Either e a)}

instance Functor m => Functor (EitherT e m) where
  fmap f = EitherT . (fmap . fmap $ f) . runEitherT

instance Applicative m => Applicative (EitherT e m) where
  pure = EitherT . pure . Right
  (EitherT f) <*> (EitherT a) = EitherT $ fmap (<*>) f <*> a

instance Monad m => Monad (EitherT e m) where
  return = pure
  eta >>= aToEtb = EitherT $ do
    --eta :: EitherT e m a
    ea <- runEitherT eta
    --runEitherT eta :: m (Either e a)
    --ea :: Either e a
    case ea of
      Left e -> return $ Left e
      Right a -> runEitherT $ aToEtb a
        --aToEtb a :: EitherT e m b
        --runEitherT $ aToEtb a :: m (Either e a)

instance MonadTrans (EitherT e) where
  lift = EitherT . (fmap Right)

--write swapEitherT helper function (Ex 4 from 26.3)
swapEitherT :: (Functor m) => EitherT e m a -> EitherT a m e
swapEitherT = EitherT . (fmap swapEither) . runEitherT

swapEither :: Either e a -> Either a e
swapEither (Left e) = Right e
swapEither (Right a) = Left a

--write the transformer version of the either catamorphism (Ex 5 from 26.3)
eitherT :: Monad m => (e -> m c) -> (a -> m c) -> EitherT e m a -> m c
eitherT fe fa e = runEitherT e >>= (either fe fa)