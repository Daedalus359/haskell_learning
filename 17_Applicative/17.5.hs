import Control.Applicative

f x =
  lookup x [ (3, "hello")
           , (4, "julie")
           , (5, "kbai")]

g y =
  lookup y [ (7, "sup")
           , (8, "chris")
           , (9, "aloha")]

h z = lookup z [(2, 3), (5, 6), (7, 8)]

m x = lookup x [(4, 10), (8, 13), (1, 9001)]

main :: IO Int
main = do
  --print (liftA2 (+) (h 2) (m 8))
  putStrLn "enter two strings"
  fmap length $ liftA2 (++) getLine getLine
