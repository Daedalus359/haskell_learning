import Control.Applicative

--boop :: Num a => a -> a
boop = (*2)

--doop :: Num a => a -> a
doop = (+10)

--bip :: Num a => a -> a
bip :: Integer -> Integer
bip = boop . doop

bbop :: Integer -> Integer
bbop = (+) <$> boop <*> doop

duwop :: Integer -> Integer
duwop = liftA2 (+) boop doop