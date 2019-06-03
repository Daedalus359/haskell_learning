module LibraryImps where

import Data.Monoid
import Data.Foldable
import Control.Applicative

--1
mySum :: (Foldable t, Num a) => t a -> a
mySum = getSum . foldMap Sum

--2
myProduct :: (Foldable t, Num a) => t a -> a
myProduct = getProduct . foldMap Product

--3
myElem :: (Foldable t, Eq a) => a -> t a -> Bool
myElem a = getAny . foldMap (Any . (a ==))

--4
myMinimum :: (Foldable t, Ord a) => t a -> Maybe a
myMinimum = foldr (maybeOrd min) Nothing

maybeOrd :: Ord a => (a -> a -> a) -> a -> Maybe a -> Maybe a
maybeOrd _ a Nothing = Just a
maybeOrd f a1 (Just a2) = Just (f a1 a2)

--5
myMaximum :: (Foldable t, Ord a) => t a -> Maybe a
myMaximum = foldr (maybeOrd max) Nothing

--6
myNull :: Foldable t => t a -> Bool
myNull dat = ( == 0) $ foldr myIncrement 0 dat

myIncrement :: a -> Int -> Int
myIncrement _ = (+1)

--7
myLen :: Foldable t => t a -> Int
myLen = foldr myIncrement 0

--8
myToList :: (Foldable t) => t a -> [a]
myToList = foldr (:) []

--9
myFold dat = foldMap id dat

--10
myFoldMap :: (Foldable t, Monoid m) => (a -> m) -> t a -> m
myFoldMap f = foldr (mappend . f) mempty