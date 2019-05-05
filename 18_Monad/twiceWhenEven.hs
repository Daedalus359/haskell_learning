import Control.Monad

twiceWhenEven :: [Integer] -> [Integer]
twiceWhenEven xs = do
  x <- xs
  if even x
    then [x*x, x*x]
    else [x*x]

tWENoDo :: [Integer] -> [Integer]
tWENoDo xs =
  xs >>= (\x -> if even x then [x*x, x*x] else [x*x])

withJoin :: [Integer] -> [Integer]
withJoin xs =
  join [(\x -> if even x then [x*x, x*x] else [x*x]) i | i <- xs]
