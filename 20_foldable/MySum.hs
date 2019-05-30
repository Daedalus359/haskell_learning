import Control.Applicative

newtype MySum a = MySum a
  deriving Show

instance Functor MySum where
  fmap f (MySum a) = MySum (f a)

instance Applicative MySum where
  pure = MySum
  (MySum f) <*> (MySum a) = MySum (f a)

instance Num a => Num (MySum a) where
  (+) = liftA2 (+)
  (-) = liftA2 (-)
  (*) = liftA2 (*)
  negate = fmap negate
  abs = fmap abs
  signum = fmap signum
  --fromInteger = pure