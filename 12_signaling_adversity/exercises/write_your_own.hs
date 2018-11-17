import Data.Maybe

--1
myIterate :: (a -> a) -> a -> [a]
myIterate f a = [f a] ++ (myIterate f (f a))

--2
addFstIfJust :: Maybe (a, b) -> [a] -> [a]
addFstIfJust Nothing lst = lst
addFstIfJust (Just (a, _)) lst = a:lst

myUnfoldr :: (b -> Maybe (a, b)) -> b -> [a]
myUnfoldr f b1 = case (f b1) of
	Nothing -> []
	Just (a, b2) -> [a] ++ myUnfoldr f b2

--function for testing purposes. Try myUnfoldr toZero 10
toZero :: Integer -> Maybe (Integer, Integer)
toZero i 
	| i > 0 = Just (i ^ 2, i - 1)
	| otherwise = Nothing

--3
betterIterate :: (a -> a) -> a -> [a]
betterIterate f = myUnfoldr (\a -> Just (f a, f a))