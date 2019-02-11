data BinaryTree a = Leaf | Node (BinaryTree a) a (BinaryTree a)
	deriving (Eq, Ord, Show)

--1
unfold :: (a -> Maybe (a, b, a)) -> a -> BinaryTree b
unfold f a = case (f a) of
	Nothing -> Leaf
	Just (a1, b, a2) -> Node (unfold f a1) b (unfold f a2)

--function for testing
toZero :: Integer -> Maybe (Integer, Integer, Integer)
toZero i 
	| i < 0 = Nothing
	| otherwise = Just (i -1, i, i - 1)

intFunc :: Integer -> Integer -> Maybe (Integer, Integer, Integer)
intFunc limit i
	| i > limit = Nothing
	| otherwise = Just (i + 1, i, i + 1)

treeBuild :: Integer -> BinaryTree Integer
treeBuild n = unfold (intFunc n) 0