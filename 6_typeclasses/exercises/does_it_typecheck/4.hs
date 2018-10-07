--typechecks, but note s1 :: Object -> Sentence
type Subject = String
type Verb = String
type Object = String

data Sentence =
    Sentence Subject Verb Object
    deriving (Eq, Show)

s1 :: Object -> Sentence
s1 = Sentence "dogs" "drool"

s1' :: Sentence
s1' = s1 "obj"

s2 :: Sentence
s2 = Sentence "Julie" "loves" "dogs"