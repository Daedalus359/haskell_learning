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

data Fiction = Fiction deriving Show
data Nonfiction = Nonfiction deriving Show
data BookType =
    FictionBook Fiction
    | NonfictionBook Nonfiction
    deriving Show

type AuthorName = String
data Author = Author (AuthorName, BookType)

data FlowerType =
    Gardenia
    | Daisy
    | Rose
    | Lilac
    deriving Show

type Gardener = String

data Garden =
    Garden Gardener FlowerType
    deriving Show

data GuessWhat = Chickenbutt deriving (Eq, Show)

data Id a = MkId a deriving (Eq, Show)

data Product a b = Product a b deriving (Eq, Show)

data Sum a b =
    First a
    | Second b deriving (Eq, Show)

data RecordProduct a b =
    RecordProduct {pfirst :: a, psecond :: b}
    deriving (Eq, Show)

newtype NumCow =
    NumCow Int
    deriving (Eq, Show)

newtype NumPig =
    NumPig Int
    deriving (Eq, Show)

data Farmhouse =
    Farmhouse NumCow NumPig
    deriving (Eq, Show)

type Farmhouse' = Product NumCow NumPig

type Farmhouse'' = (NumCow, NumPig)

data OperatingSystem =
    GnuPlusLinux
    | OpenBSD
    | Mac
    | Windows
    deriving (Eq, Show)

data ProgLang =
    Haskell
    | Agda
    | Idris
    | PureScript
    deriving (Eq, Show)

data Programmer =
    Programmer {os :: OperatingSystem
    , lang :: ProgLang }
    deriving (Eq, Show)

allOperatingSystems :: [OperatingSystem]
allOperatingSystems =
    [GnuPlusLinux
    , OpenBSD
    , Mac
    , Windows
    ]

allLanguages :: [ProgLang]
allLanguages =
    [Haskell
    , Agda
    , Idris
    , PureScript
    ]

allProgrammers :: [Programmer]
allProgrammers = [Programmer o l | o <- allOperatingSystems, l <- allLanguages]

newtype Name = Name String deriving Show
newtype Acres = Acres Int deriving Show

data FarmerType =
    DairyFarmer
    | WheatFarmer
    | SoybeanFarmer
    deriving Show

data Farmer =
    Farmer Name Acres FarmerType

isDairyFarmer :: Farmer -> Bool
isDairyFarmer (Farmer _ _ DairyFarmer) = True
isDairyFarmer _ = False