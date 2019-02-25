--exercise: write a Monoid instance for the following datatype (similar to Maybe)
data Optional a = Nada | Only a
	deriving (Eq, Show)

--Note: solution requires use of semigroup due to a change in GHC from after publication
instance Monoid a => Monoid (Optional a) where
	mempty = Nada

instance Semigroup a => Semigroup (Optional a) where
	x <> Nada = x
	Nada <> x = x
	(Only a) <> (Only b) = Only (a <> b)