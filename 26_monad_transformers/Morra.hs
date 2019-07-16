module Morra where

import Text.Trifecta
import System.Random

a = "test"

data Winner = Player1 | Player2

main :: IO ()
main = do
  gen <- newStdGen
  putStrLn "Morra vs AI"
  playAI gen

randomPrInt :: StdGen -> IO (Integer, StdGen) --add a stdGen parameter?
randomPrInt gen =
  do
    putStrLn $ "C: " ++ (show i)
    return (toInteger i, g2)
  where (i, g2) = next gen

announceWinner :: Integer -> Integer -> IO Winner --
announceWinner i1 i2 = do
  if (even (i1 + i2))
    then putStrLn "C wins" >> return Player2
    else putStrLn "P wins" >> return Player1

playAI :: StdGen -> IO ()
playAI gen = do
  putStrLn "p is Player"
  putStrLn "c is Computer"
  print "P: "
  playerResultInt <- parseString natural mempty <$> getLine
  case playerResultInt of
    Failure _ -> do
      putStrLn "parse error on input, restarting"
      playAI gen
    Success i -> do
      (compInt, nextGen) <- randomPrInt gen
      _ <- announceWinner i compInt
      return ()