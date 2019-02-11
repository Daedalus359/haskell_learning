seekritFunc :: Fractional a => String -> a
seekritFunc xs =
  numWords / wordLength
    where numWords = fromIntegral . sum . (map length) . words $ xs
          wordLength = fromIntegral . length . words $ xs