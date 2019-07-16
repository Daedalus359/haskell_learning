module RPrintAndInc where

import ReaderT

rPrintAndInc :: (Num a, Show a) => ReaderT a IO a
rPrintAndInc = ReaderT $ \r -> putStrLn ("Hi: " ++ (show r)) >> return (r + 1)