module Identity where

newtype Identity a = Identity {getIdentity :: a}
  deriving Show