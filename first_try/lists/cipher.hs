module Cipher where
    import Data.Char

    mapChar :: Int -> Char -> Char
    mapChar n c = chr . (+n) . ord $ c

    wrapChar :: Char -> Char
    wrapChar c
        |ord c < ord 'a' = wrapChar . chr $ (ord c + 26)
        |ord c - ord 'a' < 26 = c
        |otherwise = chr $ ord 'a' + (mod (ord c - ord 'a') 26)

    scramble :: Int -> String -> String
    scramble n = map (wrapChar . mapChar n)

    caesar = scramble 3

    unCaesar = scramble (-3)