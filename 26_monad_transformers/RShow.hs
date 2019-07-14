module RShow where

import Control.Monad.Trans.Reader
import Data.Functor.Identity

rShow :: Show a => ReaderT a Identity String
rShow = 
  ReaderT $ fmap Identity show