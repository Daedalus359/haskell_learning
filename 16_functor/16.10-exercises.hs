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


--testing
main :: IO ()
main = do
  quickCheck (functorIdentity :: (Identity Int -> Bool)) 
