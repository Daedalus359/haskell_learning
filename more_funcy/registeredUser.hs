module RegisteredUser where

    newtype Username =
        Username String

    newtype AccountNumber =
        AccountNumber Integer

    data User =
        UnregisteredUser
        | RegisteredUser Username AccountNumber

    printUser :: User -> IO ()
    printUser UnregisteredUser =
        putStrLn "UnregisteredUser"
    printUser (RegisteredUser
        (Username name)
        (AccountNumber acctNum)) =
        putStrLn $ name ++ " " ++ show acctNum

    data WherePenguinsLive =
        Galapagos
        | Antarctica
        | Australia
        | SouthAfrica
        | SouthAmerica
        deriving (Eq, Show)

    data Penguin =
        Peng WherePenguinsLive
        deriving (Eq, Show)

    isSouthAfrica :: WherePenguinsLive -> Bool
    isSouthAfrica SouthAfrica = True
    isSouthAfrica _ = False

    gimmerWhereTheyLive :: Penguin -> WherePenguinsLive
    gimmerWhereTheyLive (Peng whereitlives) =
        whereitlives

    humboldt = Peng SouthAmerica
    gentoo = Peng Antarctica
    macaroni = Peng Antarctica
    little = Peng Australia
    galapagos = Peng Galapagos

    galapagosPenguin :: Penguin -> Bool
    galapagosPenguin (Peng Galapagos) = True
    galapagosPenguin _ = False

    funcZ :: Integral x => x -> [Char]
    funcZ x =
        case (x + 1) == 1 of
            True -> "AWESOME"
            False -> "wut"

    functionC :: Real a => a -> a -> a
    functionC x y =
        case x > y of
            True -> x
            False -> y

    ifEvenAdd2 :: Integral a => a -> a
    ifEvenAdd2 n =
        case even n of
            True -> n + 2
            False -> n

    nums x =
        case compare x 0 of
            LT -> -1
            GT -> 1
            EQ -> 0

    dodgy x y = x + y * 10
    oneIsOne = dodgy 1
    oneIsTwo = (flip dodgy) 2

    numbers x
        | x < 0 = -1
        | otherwise = 0

    -- Composition in Haskell with . operator

    -- f . g $ x
    --print = putStrLn . show

    tensDigit :: Integral a => a -> a
    tensDigit x =
        fst $ divMod x 10

    g :: (a -> b) -> (a, c) -> (b, c)
    g f (a, c) =
        (f a, c)

    roundTrip :: (Show a, Read b) => a -> b
    roundTrip = (read :: [Char] -> b) . show