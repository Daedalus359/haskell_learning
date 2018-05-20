--Ex 1
stops = "pbt"
vowels = "aei"

allPatterns :: [Char] -> [Char] -> [(Char, Char, Char)]
allPatterns [] _ = []
allPatterns _ [] = []
allPatterns c1s c2s =
    addFront c1s $ allCombos c2s c1s

addFront :: [Char] -> [(Char, Char)] -> [(Char, Char, Char)]
addFront [] _ = []
addFront _ [] = []
addFront (c1:c1s) tups = map (\(t1, t2) -> (c1, t1, t2)) tups ++ addFront c1s tups

allCombos :: [Char] -> [Char] -> [(Char, Char)]
allCombos [] _ = []
allCombos _ [] = []
allCombos (c1:c1s) c2s = map (\c -> (c1, c)) c2s ++ allCombos c1s c2s

allPatternsStartP :: [Char] -> [Char] -> [(Char, Char, Char)]
allPatternsStartP c1s c2s = filter (\(a,b,c) -> a == 'p') $ allPatterns c1s c2s

--Ex2:
seekritFunc :: String -> Int
seekritFunc x = div (sum (map length (words x))) (length (words x))
--seekritFunc gives the (rounded down) average length of a word in the sentence x

--Ex3
fractionalSeekrit :: String -> Double
fractionalSeekrit x = (fromIntegral $ sum $ map length (words x)) / (fromIntegral $ length (words x))

--Ex1
myOr :: [Bool] -> Bool
myOr = foldr (||) False

--Ex2
myAny :: (a -> Bool) -> [a] -> Bool
myAny f = myOr . map f

--Ex3
myElem :: Eq a => a -> [a] -> Bool
myElem a = foldr (\x -> \b -> (x == a) || b) False
--myElem a = any (==a)

--Ex4
myReverse :: [a] -> [a]
myReverse xs = last xs : reverse (init xs)

--Ex5
myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr (\x -> \l-> f x : l) []

--Ex6
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f = foldr (\x -> \l -> if f x then x : l else l) []

--Ex7
