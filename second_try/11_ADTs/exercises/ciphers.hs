--The Viginere Cipher

import Data.Char

message = "MEET AT DAWN"
keyword = "ALLY"

encode :: String -> String -> String
encode = encodeInternal 0

encodeInternal :: Int -> String -> String -> String
encodeInternal _ _ [] = []
encodeInternal n key (' ':str) = ' ' : encodeInternal n key str
encodeInternal index key msg = encodedHead : encodeInternal nextIndex key (tail msg) where
    encodedHead = charAdd (key !! index) (head msg)
    nextIndex = (mod (index + 1) (length key))

charAdd :: Char -> Char -> Char
charAdd c1 c2 = chr . (+ ord 'A') . alphabetWrap . offsetFromA $ (ord c1 + (ord c2)) where
    alphabetWrap n = mod n 26
    offsetFromA n = mod n (ord 'A')