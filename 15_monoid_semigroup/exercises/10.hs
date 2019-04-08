import Data.Semigroup

data Comp a = Comp {unComp :: (a -> a)}

instance Semigroup (Comp a) where
 (Comp f1) <> (Comp f2) = Comp (f1 . f2)

--again, not testing properly. Tools below used to run a couple of tests

f = Comp (\n -> (n + 1))

g = Comp (\n -> (n * n))

h = Comp (\n -> (n - 5))

assocLeft :: (Comp a) -> (Comp a) -> (Comp a) -> (Comp a)
assocLeft f g h = (f <> (g <> h))

assocRight :: (Comp a) -> (Comp a) -> (Comp a) -> (Comp a)
assocRight f g h = ((f <> g) <> h)
