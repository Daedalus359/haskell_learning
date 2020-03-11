{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE GADTs                     #-}

module GadtDemo where

import Control.Exception
  ( ArithException(..)
  , AsyncException(..))
import Data.Typeable

data MyException =
  forall e .
  (Show e, Typeable e) => MyException e

instance Show MyException where
  showsPrec p (MyException e) =
    showsPrec p e

multiError :: Int -> Either MyException Int

multiError n = case n of
  0 -> Left $ MyException DivideByZero
  1 -> Left $ MyException StackOverflow
  _ -> Right n

--data SomeType = One 1 | Two 2 | Three 3

data IsShowable = forall s . Show s => IsShowable s

instance Show IsShowable where
  show (IsShowable s) = show s

hetList :: [IsShowable] 
hetList = [IsShowable 1, IsShowable 'c', IsShowable (Nothing :: Maybe String)]