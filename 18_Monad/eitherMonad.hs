module EitherMonad where

type Founded = Int

type Coders = Int

data SoftwareShop =
  Shop {
      founded :: Founded
    , programmers :: Coders
  } deriving (Eq, Show)

data ShopError =
     NegativeYears Founded
  |  TooManyYears Founded
  |  NegativeCoders Coders
  |  TooManyCoders Coders
  |  TooManyCodersForYears Founded Coders
  deriving (Eq, Show)

validateFounded :: Int -> Either ShopError Founded
validateFounded n
  | n < 0 = Left $ NegativeYears n
  | n > 500 = Left $ TooManyYears n
  | otherwise = Right n

validateCoders :: Int -> Either ShopError Coders
validateCoders coders
  | coders < 0 = Left $ NegativeCoders coders
  | coders > 5000 = Left $ TooManyCoders coders
  | otherwise = Right coders

validateRatio :: Int -> Int -> Either ShopError SoftwareShop
validateRatio years coders
  | years * 10 < coders = Left $ TooManyCodersForYears years coders
  | otherwise = Right $ Shop years coders

mkShop :: Int -> Int -> Either ShopError SoftwareShop
mkShop years coders =
  validateFounded years >>
  validateCoders coders >>
  validateRatio years coders

--Exercise: Look alike type for Either with Monad implementation

data Sum a b =
     First a
  |  Second b
  deriving (Eq, Show)

instance Functor (Sum a) where
  fmap f (First a) = First a
  fmap f (Second b) = Second (f b)

instance Applicative (Sum a) where
  pure b = Second b
  (First a) <*> _ = First a
  (Second f) <*> (First a) = First a
  (Second f) <*> (Second b) = Second (f b)

instance Monad (Sum a) where
  return = pure
  (First a) >>= f = First a
  (Second b) >>= f = f b

