module MyState where

newtype Moi s a = Moi {runMoi :: s -> (a, s)}

instance Functor (Moi s) where
  fmap f (Moi g) = Moi ((\(a, s) -> (f a, s)) . g)

instance Applicative (Moi s) where
  pure a = Moi (\s -> (a, s))
  (Moi fab) <*> (Moi a) = Moi (\s -> ((fst $ fab s) (fst $ a s), (snd $ a s)))

instance Monad (Moi s) where
  return = pure
  (Moi fsa) >>= faMsb = Moi (\s -> runMoi (faMsb $ fst $ fsa s) s)--what have I done


