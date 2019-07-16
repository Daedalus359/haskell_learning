module SPrintIncAccum where

import StateT

sPrintIncAccum :: (Num a, Show a) => StateT a IO String
sPrintIncAccum = StateT $ \i -> putStrLn ("Hi: " ++ (show i)) >> return (show i, i + 1)