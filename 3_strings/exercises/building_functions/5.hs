tdCIA :: String -> String
tdCIA x = take 7 (drop 9 x) ++ take 4 (drop 5 x) ++ take 5 x