module Exercises where

import Control.Monad
import Control.Monad.Trans.State

--1
myGet :: State s s
myGet = state (\s -> (s, s))

--2
myPut :: s -> State s ()
myPut s = state (\x -> ((), s))


