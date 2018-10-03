data Optional a =
    Nada
    | Only a
    deriving (Eq, Show)

instance Monoid a => Monoid (Optional a) where
    mempty = Nada
    mappend Nada (Only a) = Only a
    mappend (Only a) Nada = Only a
    mappend (Only a) (Only b) = Only (mappend a b)

newtype First' a =
    First' {getFirst' :: Optional a}
    deriving (Eq, Show)

instance Monoid (First' a) where
    mempty = First' Nada
    