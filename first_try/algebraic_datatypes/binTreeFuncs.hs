data BinaryTree a =
    Leaf
    | Node (BinaryTree a) a (BinaryTree a)
    deriving (Eq, Ord, Show)

treeMap :: (a -> b) -> BinaryTree a -> BinaryTree b
treeMap _ Leaf = Leaf
treeMap f (Node left a right) = Node (treeMap f left) (f a) (treeMap f right)

toList :: BinaryTree a -> [a]
toList Leaf = []
toList (Node left a right) = toList left ++ [a] ++ toList right

foldTree :: (a -> b -> b) -> b -> BinaryTree a -> b
foldTree _ b Leaf = b
foldTree f base (Node left a Leaf) = foldTree f (f a base) left
foldTree f base (Node left a right) = foldTree f (foldTree f base right) (Node left a Leaf)