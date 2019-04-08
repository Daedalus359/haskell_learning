import Data.Semigroup

data Validation a b = Failure a | Success b deriving (Eq, Show)

instance Semigroup a => Semigroup (Validation a b) where
  (Failure a1) <> (Failure a2) = Failure (a1 <> a2)
  (Success b) <>  _ = Success b
  (Failure _) <> (Success b) = Success b

main = do
  let 
    failure :: String -> Validation String Int
    failure = Failure
    success :: Int -> Validation String Int
    success = Success
  print $ success 1 <> failure "blach"
  print $ failure "woot" <> failure "blach"
  print $ success 1 <> success 2
  print $ failure "woot" <> success 2
