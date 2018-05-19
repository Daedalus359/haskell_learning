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

myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = x || myOr xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny fn (x:xs) = fn x || myAny fn xs

myElem :: Eq a => a -> [a] -> Bool
myElem a as = myAny (==a) as

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

mySquish :: [[a]] -> [a]
mySquish [] = []
mySquish (l:ls) = l ++ mySquish ls

mySquishMap :: (a -> [b]) -> [a] -> [b]
mySquishMap _ [] = []
mySquishMap fn as = mySquish (map fn as)

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
--need exception case for empty list
myMaximumBy fn (x:xs) = myTrackedMaxBy x fn xs where
    myTrackedMaxBy m _ [] = m
    myTrackedMaxBy m fn (x:xs)
        |fn m x == LT = myTrackedMaxBy x fn xs
        |otherwise = myTrackedMaxBy m fn xs

myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare