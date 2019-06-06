newtype Reader r a = Reader {runReader :: r -> a}

instance Functor (Reader r) where
  fmap f (Reader ra) = Reader (f . ra)

instance Applicative (Reader r) where
  pure a = Reader (const a)
  Reader frab <*> Reader fra = Reader (\r -> frab r (fra r))

instance Monad (Reader r) where
  return = pure
  (>>=) (Reader ra) aRb = Reader (\r -> runReader (aRb (ra r)) r)

ask :: Reader a a
ask = Reader id

myLiftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
myLiftA2 fabc fa fb = (fabc <$> fa) <*> fb

asks :: (r -> a) -> Reader r a 
asks = Reader

