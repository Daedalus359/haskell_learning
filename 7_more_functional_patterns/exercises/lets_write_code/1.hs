--a
tensDigit :: Integral a => a -> a
tensDigit x = snd $ divMod(fst $ divMod x 10) 10

--b yes, same type

--c
getDigit :: Integral a => Int -> a -> a
getDigit n x = snd $ divMod(fst $ divMod x p) 10
    --fst divides by 10^n
    --snd chops off last digit of result
    where p = 10^(n-1)

hunsD = getDigit 3