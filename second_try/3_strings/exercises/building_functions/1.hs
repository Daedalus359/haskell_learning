--Exercise 1 and 2

--Example
myTail :: [x] -> [x]
myTail [] = []
myTail (x:xs) = xs

--a
myBang :: String -> String
myBang x = x ++ "!"

--b
myFifth :: [x] -> x
myFifth xs = xs !! 4

--c
lastWord :: String -> String
lastWord = reverse.dropAfterSpace.reverse

--c support
dropAfterSpace :: String -> String
dropAfterSpace (' ':str) = []
dropAfterSpace (s:str) = s:(dropAfterSpace str)