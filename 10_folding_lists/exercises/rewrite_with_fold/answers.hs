--1
myOr :: [Bool] -> Bool
myOr = foldr (||) False

--2
myAny :: (a -> Bool) -> [a] -> Bool
myAny f = foldr (ev) False
    where ev val bool = (f val) || bool

--3
myElem :: Eq a => a -> [a] -> Bool
myElem a = any ((==) a)

--4
myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) []

--5
myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr func []
    where func a bs = (f a) : bs

--6
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f = foldr func []
    where func a as
            | (f a) = a : as
            | otherwise = as

--7
squish :: [[a]] -> [a]
squish = foldr (++) []

--10
