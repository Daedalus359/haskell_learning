import Data.Time

data DatabaseItem =
    DbString String
    | DbNumber Integer
    | DbDate UTCTime
    deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase = 
    [DbDate (UTCTime
    (fromGregorian 1911 5 1)
    (secondsToDiffTime 34123))
    , DbNumber 9001
    , DbString "Hello, World!"
    , DbDate (UTCTime
        (fromGregorian 1921 5 1)
        (secondsToDiffTime 34123))
    ]

filterDbByType :: (DatabaseItem -> [a] -> [a]) -> [DatabaseItem] -> [a]
filterDbByType filtFunc dbList = foldr filtFunc [] dbList

filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate = filterDbByType addIfDate

filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber = filterDbByType addIfDbNumber

addIfDate :: DatabaseItem -> [UTCTime] -> [UTCTime]
addIfDate (DbDate t) l = t:l
addIfDate _ l = l

addIfDbNumber :: DatabaseItem -> [Integer] -> [Integer]
addIfDbNumber (DbNumber n) l = n:l
addIfDbNumber _ l = l

mostRecent :: [DatabaseItem] -> UTCTime
mostRecent = maximum . (filterDbDate)

fibs :: [Integer]
fibs = 1 : scanl (+) 1 fibs

fibs20 :: [Integer]
fibs20 = take 20 fibs

fibsUnder100 :: [Integer]
fibsUnder100 = takeWhile (<100) fibs

factorials :: [Integer]
factorials = scanl (*) 1 [1..]

facts5 :: [Integer]
facts5 = take 5 factorials

fibsN :: Int -> Integer
fibsN x = fibs !! x