module Addition where

import Test.Hspec
import Test.QuickCheck

sayHello :: IO ()
sayHello = putStrLn "hello!"

mult :: (Eq a, Num a, Ord a) => a -> a -> a
mult n1 0 = 0
mult n1 n2
    | n2 > 0 = n1 + mult n1 (n2 - 1)
    | n2 < 0 = negate n1 - mult n1 (n2 + 1)

prop_additionGreater :: Int -> Bool
prop_additionGreater x = x + 1 > x

runQc :: IO ()
runQc = quickCheck prop_additionGreater

main :: IO ()
main = hspec $ do
    describe "Addition" $ do
        it "1 + 1 is greater than 1" $ do
            (1 + 1) > 1 `shouldBe` True
        it "2 + 2 = 4" $ do
            2 + 2 `shouldBe` 4
        it "x + 1 is always greater than x" $ do
            property $ \x -> x + 1 > (x :: Int)
        it "x * 1 = x" $ do
            property $ \x -> mult x 1 == (x :: Int)
        it "x times -x is negative or zero" $ do
            property $ \x -> mult (x :: Int) (negate x) <= 0