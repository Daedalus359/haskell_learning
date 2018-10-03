isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust nothing = False

isNothing :: Maybe a -> Bool
isNothing (Just _) = False
isNothing nothing = True

foFunc :: (Either a b) -> [a] -> [a]
foFunc (Right _) lst = lst
foFunc (Left itm) lst = itm:lst

lefts' :: [Either a b] -> [a]
lefts' lab = foldr foFunc [] lab