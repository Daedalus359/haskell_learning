--Ex 1:
a = fmap (+1) $ read "[1]" :: [Int]

--Ex 2:
b = (fmap . fmap) (++ "lol") (Just ["Hi", "Hello"])

--Ex 3:
c = fmap (*2) (\x -> x - 2)
--note: works because ((->) e), the type of functions that take a value e as a parameter, is a functor. Typeclassopedia says this is called the 'reader monad'

--Ex 4:
--d = fmap ((return '1' ++) . show) (\x -> [x, 1..3]) --most similar to book prompt
d = fmap (("1" ++) . show) (\x -> [x, 1..3]) --makes more sense to me

--Ex 5:
e :: IO Integer
e = let
      ioi = readIO "1" :: IO Integer
      changed = (fmap read $ fmap ("123" ++) (fmap show ioi)) :: IO Integer
    in fmap (*3) changed

--Printing answers to check:
main :: IO ()
main = do
  print a
  print b
  print (c 1)
  print (d 0)
  --e --can't figure out how to print this value out
