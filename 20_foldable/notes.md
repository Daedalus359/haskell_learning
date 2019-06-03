# Foldable

Minimal instances of Foldable are required to have ONE OF:
* foldMap
* foldr

fold :: Monoid m, Foldable t => t m -> m
fold takes a foldable with a type that has a monoid instance

foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
foldr does not rely on a monoid. However, if the function supplied to foldr is
associative and of type (a -> a -> a), then you are sort of defining a monoid for it to use

foldMap :: Monoid m, Foldable t => (a -> m) -> t a -> m
foldMap lets you take Foldables with data that has no default monoid, but which can be mapped to
a monoid. For example:
foldMap Sum [1..5] = Sum {getSum = 15}
Here, Sum (from Data.Monoid) is an unapplied data constructor for the Sum type that specifies
a monoid for numbers (addition)

running fold on an empty data structure returns mempty:
Prelude Data.Monoid Data.Foldable> fold [] :: String
""

### Demonstrating Foldable Instances

data Identity a = Identity a

instance Foldable Identity where
  foldr f z (Identity x) = f x z
  foldl f z (Identity x) = f z x
  foldMap f (Identity x) = f x

A catamorphism for this kind of data structure doesn't really reduce the values inside, since there is only one in the first place

instance Foldable Optional where -- Optional is a Maybe-ish type
  foldr f z (Yep x) = f x z
  foldr _ z (Nada) = z
  --foldl is nothing new
  foldMap _ Nada = mempty--uses mempty from the monoid specified in the type of f, even though the value of f is discarded
  foldMap f (Yep x) = f x

Note that foldMap requires an explicit monoid to be specified:

Prelude Data.Monoid> foldMap (+1) (Just 5)
	**screaming**
Prelude Data.Monoid> foldMap (+1) (Just 5) :: Sum Int
	Sum {getSum = 6}
Prelude Data.Monoid> let f = (\x -> Sum x + 1)
Prelude Data.Monoid> foldMap (+1) (Just 5) :: Sum Int
	Sum {getSum = 6}

### Some basic derived operations
toList :: Foldable t => t a -> [a]
sum :: (Foldable t, Num a) => t a -> a
product :: (Foldable t, Num a) => t a -> a
