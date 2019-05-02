--Specialize types of pure and apply for types with applicative instances

--1 --sort of done wrong the types were right
listPure :: a -> [a]
--listPure a = [a]
listPure = pure

listApply :: [a -> b] -> [a] -> [b]
--listApply [] _ = []
--listApply (f:fs) as = map f as ++ listApply fs as
listApply = (<*>)

--2
ioPure :: a -> IO a
ioPure = pure

ioApply :: IO (a -> b) -> IO a -> IO b
ioApply = (<*>)

--3
tuplePure :: Monoid b => a -> (b, a)
tuplePure = pure

tupleApply :: Monoid c => (c, (a -> b)) -> (c, a) -> (c, b)
tupleApply = (<*>)

--4
funcPure :: Monoid b => a -> (b -> a)
funcPure = pure

funcApply :: (c -> (a -> b)) -> (c -> a) -> (c -> b)
funcApply = (<*>)

--write applicative instances
--1
data Pair a = Pair a a deriving Show

instance Functor Pair where
  fmap f (Pair a1 a2) = Pair (f a1) (f a2)

instance Applicative Pair where
  pure aVal = Pair aVal aVal
  (Pair f1 f2) <*> (Pair a1 a2) = Pair (f1 a1) (f2 a2)

--2
data Two a b = Two a b

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

instance Monoid a => Applicative (Two a) where
  pure b = Two mempty b
  (<*>) (Two a1 f) (Two a2 b) = Two (a1 <> a2) (f b)

--3
data Three a b c = Three a b c

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

instance (Monoid a, Monoid b) => Applicative (Three a b) where
  pure c = Three mempty mempty c
  (Three a1 b1 f) <*> (Three a2 b2 c) = Three (a1 <> a2) (b1 <> b2) (f c)

--4
data Three' a b = Three' a b b

instance Functor (Three' a) where
  fmap f (Three' a b1 b2) = Three' a (f b1) (f b2)

instance Monoid a => Applicative (Three' a) where
  pure b = Three' mempty b b
  (Three' a1 f1 f2) (<*>) (Three' a2 b1 b2)= Three' (a1 <> a2) (f1 b1) (f2 b2)