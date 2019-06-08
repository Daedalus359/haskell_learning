module RandomExample where

import System.Random

data Die = 
    DieOne 
  | DieTwo
  | DieThree
  | DieFour
  | DieFive
  | DieSix
  deriving (Eq, Show)

intToDie :: Int -> Die
intToDie n =
  case n of
    1 -> DieOne
    2 -> DieTwo
    3 -> DieThree
    4 -> DieFour
    5 -> DieFive
    6 -> DieSix
    x ->
      error $ "intoToDie got non 1-6 integer: " ++ show x

rollDieSeeded :: Int -> (Die, Die, Die)
rollDieSeeded i = do
  let s = mkStdGen i
      (d1, s1) = randomR (1, 6) s
      (d2, s2) = randomR (1, 6) s1
      (d3, _) = randomR (1, 6) s2
  (intToDie d1, intToDie d2, intToDie d3)

rollDieThreeTimes :: (Die, Die, Die)
rollDieThreeTimes = rollDieSeeded 0
