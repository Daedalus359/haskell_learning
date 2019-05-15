{-# LANGUAGE OverladedString #-}
import Web.Scotty

import Data.Monoid (mconcat)

main = scotty 3000 $ do
  get "/:word" <- param "word"
  html $ mconcat ["<h1>Scotty, ", beam,  " me up!</h1>"]