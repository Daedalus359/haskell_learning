import Test.QuickCheck

--laws for quickchecks
functorIdentity :: (Functor f, Eq (f a)) => f a -> Bool
functorIdentity f = fmap id f == f

functorCompose :: (Eq (f c), Functor f) => (a -> b) -> (b -> c) -> f a -> Bool
functorCompose g h f = (fmap (h . g) f) == (fmap h $ fmap g f)

--Ex 1
newtype Identity a = Identity a deriving (Eq, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance (Arbitrary a) => Arbitrary (Identity a) where
  arbitrary = do
                a <- arbitrary
                return (Identity a)

--Ex 2
data Pair a = Pair a a deriving (Eq, Show)

instance Functor Pair where
  fmap f (Pair a a') = Pair (f a) (f a')

pairGen :: (Arbitrary a) => Gen (Pair a)
pairGen  = do
             a1 <- arbitrary
             a2 <- arbitrary
             return (Pair a1 a2)

instance (Arbitrary a) => Arbitrary (Pair a) where
  arbitrary = pairGen

--Ex 3
data Two a b = Two a b deriving (Eq, Show)

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

twoGen :: (Arbitrary a, Arbitrary b) => Gen (Two a b)
twoGen = do
             a <- arbitrary
             b <- arbitrary
             return (Two a b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = twoGen

--Ex 4
data Three a b c = Three a b c deriving (Eq, Show)

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

threeGen :: (Arbitrary a, Arbitrary b, Arbitrary c) => Gen (Three a b c)
threeGen = do
             a <- arbitrary
             b <- arbitrary
             c <- arbitrary
             return (Three a b c)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = threeGen

--Ex 5
data Three' a b = Three' a b b deriving (Eq, Show)

instance Functor (Three' a) where
  fmap f (Three' a b b') = Three' a (f b) (f b')

threePGen :: (Arbitrary a, Arbitrary b) => Gen (Three' a b)
threePGen = do
              a <- arbitrary
              b1 <- arbitrary
              b2 <- arbitrary
              return (Three' a b1 b2)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
  arbitrary = threePGen

--Ex 6

data Four a b c d = Four a b c d deriving (Eq, Show)

instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

fourGen :: (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Gen (Four a b c d)
fourGen = do
             a <- arbitrary
             b <- arbitrary
             c <- arbitrary
             d <- arbitrary
             return (Four a b c d)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = fourGen

--Ex 7
data Four' a b = Four' a a a b deriving (Eq, Show)

instance Functor (Four' a) where
  fmap f (Four' a1 a2 a3 b) = Four' a1 a2 a3 (f b)

fourPGen :: (Arbitrary a, Arbitrary b) => Gen (Four' a b)
fourPGen = do
              a1 <- arbitrary
              a2 <- arbitrary
              a3 <- arbitrary
              b <- arbitrary
              return (Four' a1 a2 a3 b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
  arbitrary = fourPGen

--Ex 8
--Trivial is not a functor, because you need a higher kinded type for a functor

--testing
main :: IO ()
main = do
  putStrLn "p1 check"
  quickCheck (functorIdentity :: (Identity Int -> Bool))
  putStrLn "p2 check"
  quickCheck (functorIdentity :: (Pair Int -> Bool))
  putStrLn "p3 check"
  quickCheck (functorIdentity :: (Two Int Int -> Bool))
  putStrLn "p4 check"
  quickCheck (functorIdentity :: (Three Int Int Int -> Bool))
  putStrLn "p5 check"
  quickCheck (functorIdentity :: (Three' Int Int -> Bool))
  putStrLn "p6 check"
  quickCheck (functorIdentity :: (Four Int Int Int Int -> Bool))
  putStrLn "p7 check"
  quickCheck (functorIdentity :: (Four' Int Int -> Bool))
