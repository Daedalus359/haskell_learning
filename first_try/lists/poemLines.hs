--problems 2 and 3, sec. 9.6
module PoemLines where

    firstSen = "Tyger Tyger, burning bright\n"
    secondSen = "In the forests of the night\n"
    thirdSen = "What immortal hand or eye\n"
    fourthSen = "Could frame thy fearful symmetry?"

    sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

    myLines :: String -> [String]
    myLines = splitStringBy '\n'

    shouldEqual =
        [ "Tyger Tyger, burning bright"
        , "In the forests of the night"
        , "What immortal hand or eye"
        , "Could frame thy fearful symmetry?"
        ]

    main :: IO ()
    main =
        print $
        "Are they equal? "
        ++ show (myLines sentences == shouldEqual)

    splitStringBy :: Char -> String -> [String]
    splitStringBy c xs
        |xs == [] = []
        |xs == firstWord = [xs]
        |otherwise = firstWord : ( (splitStringBy c) . tail . (dropWhile (/=c)) $ xs )
        where
            firstWord = takeWhile (/=c) xs