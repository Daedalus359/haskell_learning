data Wrap f a =
  Wrap (f a)
  deriving (Eq, Show)

--instance Functor f => Functor (Wrap f) where
  --fmap g (Wrap fa) = Wrap (fmap g fa)

instance Functor (Wrap f) where
  --fmap g (Wrap f a) = Wrap f (g a)
  fmap g (Wrap (f a)) = Wrap f (g a)
