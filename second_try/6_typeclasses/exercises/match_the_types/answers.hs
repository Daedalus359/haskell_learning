import Data.List

--1
i :: Num a => a
--i :: a --Does not work
i = 1

--2
f2 :: Float
--f :: Num a => a -- Does not work
f2 = 1.0

--3
f3 :: Fractional a => a
f3 = 1.0

--4
f4 :: RealFrac a => a
f4 = 1.0

--5
freud :: Ord a => a -> a
freud x = x

--6
freud6 :: Int -> Int
freud6 x = x

--7
myX = 1 :: Int
sigmund :: Int -> Int
sigmund x = myX

--8
sigmund' :: Int -> Int
sigmund' x = myX

--9
--jung :: Ord a => [a] -> a
jung :: [Int] -> Int
jung xs = head (sort xs)

--10
young :: Ord a => [a] -> a
young xs = head (sort xs)

--11
mySort :: [Char] -> [Char]
mySort = sort

signifier :: [Char] -> Char
--signifier :: Ord a => [a] -> a --NOPE
signifier xs = head (mySort xs)