module EitherT where

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