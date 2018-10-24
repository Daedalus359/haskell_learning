import Data.Char

--1
isSubseqOf :: (Eq a) => [a] -> [a] -> Bool
isSubseqOf [] _ = True
isSubseqOf xl@(x:xs) (y:ys)
  | x == y = isSubseqOf xs ys
  | otherwise = isSubseqOf xl ys
isSubseqOf _ [] = False

--2
capitalizeWords :: String -> [(String, String)]
capitalizeWords [] = []
capitalizeWords (' ':str) = capitalizeWords str
capitalizeWords str = (fst wordSplit, capitalizeString . fst $ wordSplit) : (capitalizeWords . snd $ wordSplit)
  where wordSplit = splitAtChar ' ' str


capitalizeString :: String -> String
capitalizeString [] = []
capitalizeString word@(l:ls)
  | (ord l > (ord 'a' - 1)) && (ord l < (ord 'z' + 1)) = (chr . (+ (ord 'A' - ord 'a')) . ord $ l):ls
  | otherwise = word

splitAtChar :: Char -> String -> (String, String)
splitAtChar c [] = ([], [])
splitAtChar c (l:ls)
  | l == c = (l:[], ls)
  | otherwise = (l : fst rest, snd rest)
    where rest = splitAtChar c ls

--Language exercises
--1, see capitalizeString
--2

capitalizeParagraph :: String -> String
capitalizeParagraph [] = []
capitalizeParagraph (' ':str) = ' ' : capitalizeParagraph str
capitalizeParagraph str = (++) (capitalizeString . fst . (splitAtChar '.') $ str) (capitalizeParagraph . snd . (splitAtChar '.') $ str)