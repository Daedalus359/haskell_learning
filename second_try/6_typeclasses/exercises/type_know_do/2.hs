-- Hint: use some arithmetic operation to
-- combine values of type 'b'. Pick one.
arith :: Num b
    => (a -> b)
    -> Integer
    -> a
    -> b

arith ab _ a = ab a