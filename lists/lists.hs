--Chapter 9, Haskell Programming From First Principles

import Data.Char

--9.3
myHead :: [t] -> Maybe t
myHead (x : _) = Just x
myHead [] = Nothing

myTail :: [a] -> Maybe [a]
myTail [] = Nothing
myTail (_ : xs) = Just xs

--9.5
myEnumFromTo :: (Enum a, Ord a) => a -> a -> [a]
myEnumFromTo start end
    |start > end = []
    |start == end = [start]
    |otherwise = start : myEnumFromTo (succ start) end

--9.6
myWords :: String -> [String]
myWords xs
    |xs == [] = []
    |xs == firstWord = [xs]
    |otherwise = firstWord : ( myWords . tail . (dropWhile (/=' ')) $ xs )
    where
        firstWord = takeWhile (/=' ') xs

--9.7
mySqr = [x^2 | x <- [1..5]]
myCube = [y^3 | y <- [1..5]]

myTups = [(x, y) | x <- mySqr, y <- myCube, x < 50, y < 50]

myLen = length myTups

--9.11

myZip :: [a] -> [b] -> [(a,b)]
myZip [] _ = []
myZip _ [] = []
myZip (a:as) (b:bs) = (a,b) : myZip as bs

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] _ = []
myZipWith _ _ [] = []
myZipWith f (a:as) (b:bs) = f a b : (myZipWith f as bs)

myZip' as bs = myZipWith (\x -> \y -> (x,y)) as bs

--Exercises

filterUpper = filter (\x -> isUpper x)

capitalizeSentence :: String -> String
capitalizeSentence "woot" = "WOOT"
capitalizeSentence (c:cs) = toUpper c : cs

flUpper = toUpper . head