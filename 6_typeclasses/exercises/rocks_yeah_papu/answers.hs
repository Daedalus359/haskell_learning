data Rocks =
    Rocks String deriving (Eq, Show)

data Yeah =
    Yeah Bool deriving (Eq, Show)

data Papu =
    Papu Rocks Yeah
    deriving (Eq, Show)

--1 - fixed with proper data constructors
phew = Papu (Rocks "chases") (Yeah True)

--2
truth = Papu (Rocks "dfkjgndfg") (Yeah True)

--3
equalityForAll :: Papu -> Papu -> Bool
equalityForAll p p' = p == p'

--4 (>) won't typecheck without an instance of Ord for Papu
comparePapus :: Papu -> Papu -> Bool
comparePapus p p' = p == p'