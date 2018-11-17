data Nat =
    Zero
    | Succ Nat
    deriving (Eq, Show)

natToInteger :: Nat -> Integer
natToInteger Zero = 0
natToInteger (Succ nt) = 1 + natToInteger nt

integerToNat :: Integer -> Maybe Nat
integerToNat i 
    | i < 0 = Nothing
    | i == 0 = Just Zero
    | otherwise = Just $ posToNat i
        where
            posToNat :: Integer -> Nat
            posToNat 0 = Zero
            posToNat i = Succ (posToNat $ i - 1)