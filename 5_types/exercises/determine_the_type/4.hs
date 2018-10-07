{-# LANGUAGE NoMonomorphismRestriction #-}

x = 5
y = x + 5

f :: Fractional a => a
f = 4 / y