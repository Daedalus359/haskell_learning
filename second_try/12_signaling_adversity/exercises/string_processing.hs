--1
notThe :: String -> Maybe String
notThe s 
	| (elem s ["the", "The"]) = Nothing
	| otherwise = Just s

replaceThe :: String -> String
replaceThe str
	| (notThe $ take 3 str) == Nothing = "a" ++ (replaceThe $ drop 3 str)
	| str == [] = []
	| otherwise = take 1 str ++ (replaceThe $ drop 1 str)

--2
vowels = "aeiou"

sentence :: [String] -> String
sentence [] = []
sentence (word:ws) = concat [word, " ", sentence ws]

countTheBeforeVowel :: String -> Integer
countTheBeforeVowel str
	| length wordList < 2 = 0
	| (notThe (head wordList) == Nothing) && (elem (head $ wordList !! 1) vowels) = 1 + countTheBeforeVowel (sentence $ tail wordList)
	| otherwise = 0 + countTheBeforeVowel (sentence $ tail wordList)
		where wordList = words str

--3
countVowels :: String -> Int
countVowels [] = 0
countVowels (l:word)
	| elem l vowels = 1 + countVowels word
	| otherwise = 0 + countVowels word