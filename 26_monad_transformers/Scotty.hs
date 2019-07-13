{-# LANGUAGE OverloadedStrings #-}

module Scotty where

import Web.Scotty
import Control.Monad.Trans.Class
import Control.Monad.IO.Class

import Data.Monoid (mconcat)

main = scotty 3000 $ do
  get "/:word" $ do
    beam <- param "word"
    --(lift :: IO () -> ActionM ()) (putStrLn "hello")--previous exercise
    liftIO (putStrLn "hello")--
    html  $
            mconcat ["<h1>Scotty, ",
                     beam,
                     " me up!</h1>"]