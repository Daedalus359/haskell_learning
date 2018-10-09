combos :: [a] -> [a] -> [(a,a,a)]
combos fl sl = [(c1, v, c2) | c1 <- fl, v <- sl, c2 <- fl]

--a
stops = "pbg"
vowels = "ae"
partA = combos stops vowels

--b
partB = [(c1, a, c2) | (c1, a, c2) <- (combos stops vowels), (c1 == 'p')]

--c
nouns = ["Kevin", "Linus", "rock"]
verbs = ["eat", "build"]

partC = combos nouns verbs

main :: IO ()
main = do
  print partA
  print partB
  print partC