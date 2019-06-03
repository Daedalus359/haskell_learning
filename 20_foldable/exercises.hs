--1
data Constant a b = Constant b

instance Foldable (Constant a) where
  foldr f b (Constant a) = f a b

--2
data Two a b = Two a b

instance Foldable (Two a) where
  foldr f c (Two a b) = f b c

--3
data Three a b c = Three a b c

instance Foldable (Three a b) where
  foldr f d (Three a b c) = f c d

--4
data Three' a b = Three' a b b

instance Foldable (Three' a) where
  foldr f c (Three' a b1 b2) = f b2 (f b1 c)

--5
data Four' a b = Four' a b b b

instance Foldable (Four' a) where
  foldr f c (Four' a b1 b2 b3) = foldr f c [b1, b2, b3]

filterF :: (Applicative f, Foldable t, Monoid (f a)) => (a -> Bool) -> t a -> f a
filterF aToBool foldabl = foldMap (\a -> if (aToBool a) then (pure a) else mempty) foldabl
--ex:
  --filterF (>1) [1,2,3] :: [Int]
  --filterF (>1) (Just 2) :: [Int]