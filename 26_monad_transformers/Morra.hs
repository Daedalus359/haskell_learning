module Morra where

import StateT

import Text.Trifecta
import System.Random

a = "test"

data Winner = Player1 | Player2

data GameState = GameState
  { p13Grams :: [(Integer, Integer, Integer)]
  , p1Last2Moves :: (Integer, Integer)
  , getGen :: StdGen
  }

newGameState :: StdGen -> GameState
newGameState gen = GameState [] (0, 0) gen--just a hack, assume player only ever does 1 and 2

recMove :: Integer -> StdGen -> GameState -> GameState
recMove i newGen (GameState p13g p1l2m gen) =
  GameState (threeGram : p13g) cycledMoves newGen
  where
    threeGram = (\l -> \(j, k) -> (j, k, l)) i p1l2m
    cycledMoves = (\(j, k, l) -> (k, l)) threeGram
--runGame :: StateT GameState IO Winner

main :: IO ()
main =
  do
    gen <- newStdGen
    putStrLn "Morra vs AI"
    continueGame $ newGameState gen

continueGame :: GameState -> IO ()
continueGame gs = do
  (i, newGen) <- playRoundAI $ getGen gs
  continueGame $ recMove i newGen gs

randomPrInt :: StdGen -> IO (Integer, StdGen) --add a stdGen parameter?
randomPrInt gen =
  do
    putStrLn $ "C: " ++ (show i)
    return (toInteger i, g2)
  where (i, g2) = next gen

smartMove :: GameState -> IO ()
smartMove = undefined

announceWinner :: Integer -> Integer -> IO Winner --
announceWinner i1 i2 =
  if (even (i1 + i2))
    then putStrLn "C wins" >> return Player2
    else putStrLn "P wins" >> return Player1

playRoundAI :: StdGen -> IO (Integer, StdGen)
playRoundAI gen = do
  putStrLn "p is Player"
  putStrLn "c is Computer"
  print "P: "
  playerResultInt <- parseString natural mempty <$> getLine
  case playerResultInt of
    Failure _ -> do
      putStrLn "parse error on input, restarting"
      playRoundAI gen
    Success i -> do
      (compInt, nextGen) <- randomPrInt gen
      _ <- announceWinner i compInt
      return (i, nextGen)