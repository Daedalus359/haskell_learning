data DayOfWeek =
    Mon | Tue | Weds | Thu | Fri | Sat | Sun
    deriving Show

data Date =
    Date DayOfWeek Int
    deriving Show

instance Eq DayOfWeek where
    (==) Mon Mon = True
    (==) Tue Tue = True
    (==) Weds Weds = True
    (==) Thu Thu = True
    (==) Fri Fri = True
    (==) Sat Sat = True
    (==) Sun Sun = True
    (==) _ _ = False

instance Eq Date where
    (==) (Date weekday dayOfMonth) (Date weekday' dayOfMonth') =
        weekday == weekday' && dayOfMonth == dayOfMonth'

data StringOrInt =
    TisAnInt Int
    | TisAString String

instance Eq StringOrInt where
    (==)  (TisAnInt int1) (TisAnInt int2) = (==) int1 int2
    (==) (TisAString str1) (TisAString str2) = (==) str1 str2
    (==) _ _ = False

data Tuple a b =
    Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
    (==) (Tuple a b) (Tuple a' b') = (==) a a' && (==) b b'

data EitherOr a b =
    Hello a
    | Goodbye b

instance (Eq a, Eq b) => Eq (EitherOr a b) where
    (==) (Hello a) (Hello a') = (==) a a'
    (==) (Goodbye b) (Goodbye b') = (==) b b'
    (==) _ _ = False