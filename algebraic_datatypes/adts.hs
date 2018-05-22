data Price =
    Price Integer deriving (Eq, Show)

data Size =
    Size Integer deriving (Eq, Show)

data Manufacturer =
    Mini
    | Mazda
    | Tata
    deriving (Eq, Show)

data Airline =
    PapuAir
    |CatapultsR'Us
    |TakeYourChancesUnited
    deriving(Eq, Show)

data Vehicle =
    Car Manufacturer Price
    | Plane Airline Size
    deriving(Eq, Show)

data Example = MakeExample Int deriving Show

class TooMany a where
    tooMany :: a -> Bool

newtype IntStringTup =
    IntStringTup (Int, String)

newtype IntIntTup =
    IntIntTup (Int, Int)

instance TooMany IntIntTup where
    tooMany (IntIntTup (i1,i2)) = (i1 + i2) > 42

instance TooMany IntStringTup where
    tooMany (IntStringTup (i, s)) = i > 42

isCar :: Vehicle -> Bool
isCar (Car _ _) = True
isCar _ = False

isPlane :: Vehicle -> Bool
isPlane (Plane _ _ ) = True
isPlane _ = False

areCars :: [Vehicle] -> [Bool]
areCars = map isCar

--Note: following does not work for Plane data
getManu :: Vehicle -> Manufacturer
getManu (Car manu _) = manu

myCar = Car Mini (Price 14000)

urCar = Car Mazda (Price 20000)

clownCar = Car Tata (Price 7000)

doge = Plane PapuAir