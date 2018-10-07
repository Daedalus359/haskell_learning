chk :: Eq b => (a -> b) -> a -> b -> Bool
chk ab a b = b == ab a