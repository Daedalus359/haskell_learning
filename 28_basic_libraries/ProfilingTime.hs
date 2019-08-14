module Main where

f :: IO ()
f = do
  print ([1..] !! 999999)
  putStrLn "f"

g :: IO ()
g = do
  print ([1..] !! 9999999) --note the one additional digit compared to f
  putStrLn "g"

main :: IO ()
main = do
  f
  g
 