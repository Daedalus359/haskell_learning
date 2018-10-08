foldBool :: a -> a -> Bool -> a

--case expression
--foldBool a1 a2 b = if b then a1 else a2

--guard
foldBool a1 a2 b
    | b = a1
    | otherwise = a2