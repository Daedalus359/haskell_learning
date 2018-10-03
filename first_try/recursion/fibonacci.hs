fibonacci :: Integer -> Integer
fibonacci x
    |x == 0 = 1
    |x == 1 = 1
    |x < 0 = 1
    |otherwise = fibonacci (x - 1) + fibonacci (x - 2)

intDiv :: Integer -> Integer -> Integer
intDiv x y
    | y > x = 0
    | otherwise = 1 + intDiv (x - y) y

sumFirstN :: (Ord a, Num a) => a -> a
sumFirstN n
    |n <= 1 = 1
    |otherwise = n + sumFirstN (n - 1)

mc91 :: Integral a => a -> a
mc91 n
    | n > 100 = n - 10
    |otherwise = mc91 (mc91 (n + 11))

digitToWord :: Int -> String
digitToWord n
    |n == 0 = "zero"
    |n == 1 = "one"
    |n == 2 = "two"
    |n == 3 = "three"
    |n == 4 = "four"
    |n == 5 = "five"
    |n == 6 = "six"
    |n == 7 = "seven"
    |n == 8 = "eight"
    |n == 9 = "nine"
    |otherwise = "unknown digit"

digits :: Int -> [Int]
digits n
    |n < 10 = [n]
    |otherwise = digits (div n 10) ++ [mod n 10]

digsWords :: [Int] -> [String]
digsWords intList = map digitToWord intList

listToString :: [String] -> String
listToString x
    |x == [] = ""
    |otherwise = "-" ++ head x ++ listToString (tail x)

wordNumber :: Int -> String
wordNumber =
    tail . listToString . digsWords . digits