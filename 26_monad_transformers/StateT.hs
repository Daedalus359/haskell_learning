module StateT where

newtype StateT s m a =
  StateT {runStateT :: s -> m (a, s)}

