newtype Constant a b = Constant {getConstant :: a}
  deriving (Eq, Ord, Show)

instance Functor (Constant a) where
  fmap _ (Constant a) = (Constant a)

instance Monoid a => Applicative (Constant a) where
  pure e = Constant mempty
  (Constant a1) <*> (Constant a2) = Constant (a1 <> a2)
