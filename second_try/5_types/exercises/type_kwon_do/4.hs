munge :: (x -> y)
	-> (y -> (w, z))
	-> x
	-> w

munge f1 f2 = fst . f2 . f1