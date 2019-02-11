--1
isJust :: Maybe a -> Bool
isJust Nothing = False
isJust (Just _) = True

isNothing :: Maybe a -> Bool
isNothing = not . isJust

--2
mayybee :: b -> (a -> b) -> Maybe a -> b
mayybee b _ Nothing = b
mayybee _ f (Just a) = f a

--3
fromMaybe :: a -> Maybe a -> a
fromMaybe a = mayybee a id

--4
listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (l:lst) = Just l

--5
catMaybes :: [Maybe a] -> [a]
catMaybes = (fmap (\(Just a) -> a)) . (filter isJust)

--6
flipMaybe :: [Maybe a] -> Maybe [a]
flipMaybe lst 
	| length lst == length justs = Just $ catMaybes lst
	| otherwise = Nothing
		where justs = catMaybes lst