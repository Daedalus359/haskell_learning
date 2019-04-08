data Possibly a = LolNope | Yeppers a deriving (Eq, Show)

instance Functor Possibly where
  fmap f LolNope = LolNope
  fmap f (Yeppers a) = Yeppers (f a)

data OneOf a b = First a | Second b deriving (Eq, Show)

instance Functor (OneOf a) where
  fmap _ (First a) = First a
  fmap f (Second b) = Second (f b) 
