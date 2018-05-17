module Cipher where
    import Data.Char

    mapChar :: Int -> Char -> Char
    mapChar n c = chr . (+n) . ord $ c

    scramble :: Int -> String -> String
    scramble n = map (mapChar n)

    caesar = scramble 3

    unCaesar = scramble (-3)