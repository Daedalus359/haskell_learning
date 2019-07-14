module RDec where

import Control.Monad.Trans.Reader
import Data.Functor.Identity

rDec :: Num a => Reader a a
rDec = ReaderT (\i -> Identity (i - 1))