module Exercises where

newtype State s a = State {runState :: s -> (a, s)}

--1
get :: State s s
get = State (\s -> (s, s))

--2
put :: s -> State s ()
put s = State (\x -> ((), s))

--3
exec :: State s a -> s -> s
exec (State sa) s = snd $ sa s

--4
eval :: State s a -> s -> a
eval st@(State sa) s = fst $ runState st s

--5
modify :: (s -> s) -> State s ()
modify fss = State (\s -> ((), fss s))
