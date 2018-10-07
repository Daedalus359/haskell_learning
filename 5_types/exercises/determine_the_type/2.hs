{-# LANGUAGE NoMonomorphismRestriction #-}

x = 5
y = x + 5

w :: Num a => a
w = y * 10