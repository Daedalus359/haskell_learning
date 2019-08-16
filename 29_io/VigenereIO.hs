module Main where

import System.Environment
import System.IO
import System.Exit

printSequence :: String -> IO a -> IO a
printSequence s ioa = putStr (s ++ ", ") >> ioa

loopRevLines :: Int -> IO ()
loopRevLines 0 = return ()
loopRevLines n = wait >> putStr (show n ++ ": ") >> (fmap reverse (hGetLine stdin)) >>= putStrLn >> (loopRevLines $ n - 1)

wait :: IO ()
wait = do
  success <- hWaitForInput stdin (3000)
  if success
    then return ()
    else die "timeout 3000ms"

main :: IO ()
main = do
  args <- getArgs
  foldr printSequence (putStrLn "END") args
  loopRevLines 5