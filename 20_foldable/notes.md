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