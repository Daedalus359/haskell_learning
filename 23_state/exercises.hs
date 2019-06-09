module Exercises where

import Control.Monad
import Control.Monad.Trans.State

--1
get :: State s s
get = State (\s -> (s, s))
