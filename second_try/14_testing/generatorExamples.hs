import Test.QuickCheck

--return :: Monad m => a -> m a
trivialInt :: Gen Int
trivialInt = return 1

--elements <list of n values> is a generator that returns any of the n values with uniform probability
oTT :: Gen Int
oTT = elements [1, 2, 3]

genChar :: Gen Char
genChar = elements ['a'..'z']

--try: 
--  $sample' (genThree :: Gen (Int, Double, Integer))
genThree :: (Arbitrary a, Arbitrary b, Arbitrary c) => Gen (a, b, c)
genThree = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (a, b, c)

genEither :: (Arbitrary a, Arbitrary b) => Gen (Either a b)
genEither = do
    a <- arbitrary
    b <- arbitrary
    elements [Left a, Right b]

--frequency :: [(Int, Gen a)] -> Gen a
weightedMaybe :: Arbitrary a => Gen (Maybe a)
weightedMaybe = do
    a <- arbitrary
    frequency [(1, return Nothing), (3, return (Just a))]