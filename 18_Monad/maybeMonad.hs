data Cow = Cow {
    name :: String
  , age :: Int
  , weight :: Int
  } deriving (Eq, Show)

weightCheck :: Cow -> Maybe Cow
weightCheck cow
  | name cow /= "Bess" = Just cow
  | otherwise = if weight cow > 499 then Nothing else Just cow

noEmpty :: String -> Maybe String
noEmpty "" = Nothing
noEmpty str = Just str

noNegative :: Int -> Maybe Int
noNegative n
  | n >= 0 = Just n
  | otherwise = Nothing

--without taking advantage of Maybe Monad
mkSphericalCow :: String -> Int -> Int -> Maybe Cow
mkSphericalCow nam ag wt =
  case noEmpty nam of
    Nothing -> Nothing
    Just nam' ->
      case noNegative ag of
        Nothing -> Nothing
        Just ag' ->
          case noNegative wt of
            Nothing -> Nothing
            Just wt' ->
              weightCheck (Cow nam ag wt)

mkWithMonads :: String -> Int -> Int -> Maybe Cow
mkWithMonads nam ag wt = do
  nammy <- noEmpty nam
  agey <- noNegative ag
  weighty <- noNegative wt
  weightCheck (Cow nammy agey weighty)

testMonads :: Int -> Maybe Int
testMonads ag = do
  agey <- noNegative ag
  return ag --works with agey as well

kevinVersion :: String -> Int -> Int -> Maybe Cow
kevinVersion nam ag wt =
  noEmpty nam >>
  noNegative ag >>
  noNegative wt >>
  weightCheck (Cow nam ag wt)

  

