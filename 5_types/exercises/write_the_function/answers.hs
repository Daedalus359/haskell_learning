--1
i :: a -> a
i x = x

--2
c :: a -> b -> a
c a b = a

--3
c'' :: b -> a -> b
c'' = c

--4
c' :: a -> b -> b
c' a b = b

--5
r :: [a] -> [a]
r = reverse

--6
co :: (b -> c) -> (a -> b) -> a -> c
co = (.)

--7
a :: (a -> c) -> a -> a
a _ x = x

--8
a' :: (a -> b) -> a -> b
a' f = f