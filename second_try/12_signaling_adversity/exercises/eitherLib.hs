--1
addIfLeft :: Either a b -> [a] -> [a]
addIfLeft (Left a) lst = a:lst
addIfLeft (Right _) lst = lst

lefts' :: [Either a b] -> [a]
lefts' = foldr addIfLeft []

--2
addIfRight :: Either a b -> [b] -> [b]
addIfRight (Right a) lst = a:lst
addIfRight (Left _) lst = lst

rights' :: [Either a b] -> [b]
rights' = foldr addIfRight []

--3
sortIntoList :: Either a b -> ([a], [b]) -> ([a], [b])
sortIntoList (Left a) (as, bs) = (a:as, bs)
sortIntoList (Right b) (as, bs) = (as, b:bs)

partitionEithers' :: [Either a b] -> ([a], [b])
partitionEithers' = foldr sortIntoList ([], [])

--4
eitherMaybe :: (b -> c) -> Either a b -> Maybe c
eitherMaybe bToC (Right b) = Just (bToC b)
eitherMaybe _ (Left _) = Nothing

--5
either' :: (a -> c) -> (b -> c) -> Either a b -> c
either' f _ (Left a) = f a
either' _ f (Right b) = f b