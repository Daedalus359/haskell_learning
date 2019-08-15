module Main where

import Criterion.Main

newtype DList a = DL {unDL :: [a] -> [a]}

empty :: DList a
empty = DL id
{-# INLINE empty #-}

singleton :: a -> DList a
singleton a = DL $ ([a] ++ )
{-# INLINE singleton #-}

toList :: DList a -> [a]
toList dl = unDL dl []
{-# INLINE toList #-}

infixr `cons`
cons :: a -> DList a -> DList a
cons x xs = DL ((x:) . unDL xs)
{-# INLINE cons #-}

--toList $ snoc (singleton 'a') 'b'
infixl `snoc`
snoc :: DList a -> a -> DList a
snoc xs x = append xs (singleton x)--DL (((++) $ unDL xs undefined) . const [x])
{-# INLINE snoc #-}

--toList $ append (singleton 'a') (singleton 'b')
append :: DList a -> DList a -> DList a
append l1 l2 = DL (unDL l1 . unDL l2) --DL (((++) $ unDL l1 undefined) . (unDL l2))
{-# INLINE append #-}

--construct a list of integers in descending order
schlemiel :: Int -> [Int]
schlemiel i = go i []
  where go 0 xs = xs
        go n xs = go (n-1) ([n] ++ xs)

--same thing via DLists
constructDlist :: Int -> [Int]
constructDlist i = toList $ go i empty
  where go 0 xs = xs
        go n xs = go (n - 1) (singleton n `append` xs)


main :: IO ()
main = defaultMain
  [ bench "concat list" $
    whnf schlemiel 123456
  , bench "concat dlist" $
    whnf constructDlist  123456
  ]

