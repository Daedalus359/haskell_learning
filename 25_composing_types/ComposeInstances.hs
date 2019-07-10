module ComposeInstances where

import Data.Foldable
import Data.Traversable

newtype Compose f g a =
  Compose {getCompose :: f (g a)}
  deriving (Eq, Show)

instance (Functor f1, Functor f2) => Functor (Compose f1 f2) where
  fmap f (Compose fga) = Compose $ (fmap . fmap)  f fga

instance (Applicative f1, Applicative f2) => Applicative (Compose f1 f2) where
  pure = Compose . pure . pure --outmermostpure takes a to (f2 a). Next one gets to (f1 (f2 a))
  (Compose fgab) <*> (Compose fga) = Compose $ (fmap (<*>) fgab) <*> fga

instance (Foldable f, Foldable g) => Foldable (Compose f g) where
  foldMap aToMon (Compose fga) = foldMap (foldMap aToMon) fga
  fold (Compose fga) = foldMap fold fga--just to see if I could

instance (Traversable t1, Traversable t2) => Traversable (Compose t1 t2) where
  traverse aToAB (Compose tta) = Compose <$> traverse (traverse aToAB) tta