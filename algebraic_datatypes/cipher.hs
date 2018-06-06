module Cipher where
    import Data.Char

    mapChar :: Int -> Char -> Char
    mapChar n c = chr . (+n) . ord $ c

    wrapChar :: Char -> Char
    wrapChar c
        |ord c < ord 'a' = wrapChar . chr $ (ord c + 26)
        |ord c - ord 'a' < 26 = c
        |otherwise = chr $ ord 'a' + (mod (ord c - ord 'a') 26)

    vigenere :: String -> String -> String
    vigenere _ "" = ""
    vigenere f (' ':str) = ' ' : vigenere f str
    vigenere scrambler msg = wrapChar (mapChar ((ord . head $ scrambler) - ord 'a') (head msg)) : vigenere (tail scrambler ++ [head scrambler]) (tail msg)