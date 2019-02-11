seekritFunc :: String -> Int
seekritFunc x =
  div (sum (map length (words x)))
    (length (words x))

--this function returns the average word length from a sentence (string)