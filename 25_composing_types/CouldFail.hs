module CouldFail where

--wrote this to remind myself of what is involved in writing a Monad instance
data CouldFail a = Didnt a | DidFail

instance Functor CouldFail where
  fmap f (Didnt a) = Didnt $ f a
  fmap f DidFail = DidFail

instance Applicative CouldFail where
  pure = Didnt
  (Didnt f) <*> (Didnt a) = Didnt $ f a
  _ <*> DidFail = DidFail
  DidFail <*> _ = DidFail

instance Monad CouldFail where
  return =  pure
  (Didnt a) >>= aToCFb = aToCFb a
  DidFail >>= _ = DidFail