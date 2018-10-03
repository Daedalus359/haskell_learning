module Exercises where

    isPalindrome :: (Eq a) => [a] -> Bool
    isPalindrome a = if a == (reverse a) then True else False

    f :: (a, b) -> (c, d) -> ((b, d), (a, c))
    f x y = ((snd x, snd y), (fst x, fst y))