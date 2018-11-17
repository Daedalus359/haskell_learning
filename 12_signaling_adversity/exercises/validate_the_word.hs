vowels = "aeiou"

--calling anything not a lowercase vowel a consonant
vowelConsonantCounts :: String -> (Int, Int) -> (Int, Int)
vowelConsonantCounts [] (vc, cc) = (vc, cc)
vowelConsonantCounts (l:word) (vc, cc) = vowelConsonantCounts word newCount
	where newCount
		| elem l vowels = (vc + 1, cc)
		| otherwise = (vc, cc + 1)

--validate a word if it does not have more vowels than consonants
mkWord :: String -> Maybe String
mkWord str 
	| vc > cc = Nothing
	| otherwise = Just str
		where (vc, cc) = vowelConsonantCounts str (0, 0)