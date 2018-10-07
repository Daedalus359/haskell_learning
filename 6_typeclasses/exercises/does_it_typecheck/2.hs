--added deriving Eq
data Mood = Blah
    | Woot deriving (Show, Eq)

settleDown :: Mood -> Mood
settleDown x = if x == Woot
    then Blah
    else x