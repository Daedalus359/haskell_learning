g :: (a -> b) -> (a, c) -> (b, c)
g ab (a, c) = (ab a, c)