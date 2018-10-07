{-# LANGUAGE NoMonomorphismRestriction #-}

x = 5
y = x + 5

z :: (Num a) => a -> a
z y = y * 10