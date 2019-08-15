module Main where

import Criterion.Main
import Data.Maybe

data Queue a = 
  Queue { enqueue :: [a]
        , dequeue :: [a]
        } deriving (Eq, Show)

empty :: Queue a
empty = Queue [] []

push :: a -> Queue a -> Queue a
push a (Queue en de) = Queue (a : en) de

pop :: Queue a -> Maybe (a, Queue a)
pop (Queue [] []) = Nothing
pop (Queue en (x:xs)) = Just (x, Queue en xs)
pop (Queue en@(x:xs) []) = pop (Queue [] $ reverse en)

type QueueL = []

pushL :: a -> QueueL a -> QueueL a
pushL = (:)

popL :: QueueL a -> Maybe (a, QueueL a)
popL [] = Nothing
popL q@(x:xs) = Just (last q, init q) 

push2Pop1Q :: Int -> Queue Int -> Queue Int
push2Pop1Q n (Queue [] []) = push2Pop1Q n (Queue [5] [])
push2Pop1Q 0 q = q
push2Pop1Q n q = push2Pop1Q (n - 1) $
  case remainder of
    0 -> push 0 q
    1 -> push 1 q
    2 -> fromMaybe (Queue [6] [7]) $ fmap snd (pop q)

  where remainder = rem n 3

lVersion :: Int -> QueueL Int -> QueueL Int
lVersion n [] = lVersion n [5]
lVersion 0 q  = q
lVersion n q@(x:xs) = lVersion (n - 1) $
  case remainder of
    0 -> pushL 0 q
    1 -> pushL 1 q
    2 -> fromMaybe [6,7] $ fmap snd (popL q)

  where remainder = rem n 3

main :: IO ()
main = defaultMain
  [ bench "enqueue and dequeue version" $ whnf (push2Pop1Q 1000) empty
  , bench "single list version" $ whnf (lVersion 1000) []
  ]