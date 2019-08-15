module DifferenceList where

newtype DList a = DL {unDL :: [a] -> [a]}

empty :: DList a
empty = DL id
{-# INLINE empty #-}

singleton :: a -> DList a
singleton a = DL $ const [a]
{-# INLINE singleton #-}

toList :: DList a -> [a]
toList dl = unDL dl undefined
{-# INLINE toList #-}

infixr `cons`
cons :: a -> DList a -> DList a
cons x xs = DL ((x:) . unDL xs)
{-# INLINE cons #-}

--toList $ snoc (singleton 'a') 'b'
infixl `snoc`
snoc :: DList a -> a -> DList a
snoc xs x = DL (((++) $ unDL xs undefined) . const [x])
{-# INLINE snoc #-}

--toList $ append (singleton 'a') (singleton 'b')
append :: DList a -> DList a -> DList a
append l1 l2 = DL (((++) $ unDL l1 undefined) . (unDL l2))
{-# INLINE append #-}