{-# LANGUAGE OverloadedStrings #-}

module HitCounter where

--Does not actually work!

import Control.Monad.Trans.Class
import Control.Monad.Trans.Reader
import Data.IORef
import qualified Data.Map as M
import Data.Maybe (fromMaybe)
import Data.Text.Lazy (Text)
import qualified Data.Text.Lazy as TL
import System.Environment (getArgs)
import Web.Scotty.Trans

--new imports
--import Web.Scotty

data Config =
  Config {
    counts :: IORef (M.Map Text Integer)
  , prefix :: Text
  }

type Scotty = ScottyT Text (ReaderT Config IO)

type Handler = ActionT Text (ReaderT Config IO)

bumpBoomp :: Text -> M.Map Text Integer -> (M.Map Text Integer, Integer)
bumpBoomp t map = (newMap, hits)
  where
    maybeVal = M.lookup t map
    hits = (fromMaybe 0 maybeVal) + 1
    newMap = M.insert t hits map

app :: Scotty ()
app =
    get "/:key" $ do
    unprefixed <- (param $ TL.pack "key") :: ActionT Text (ReaderT Config IO) Text --type?
    --let key' = mappend undefined unprefixed
    newInteger <- (undefined :: ActionT Text (ReaderT Config IO) Integer)
    html $ mconcat 
            [ "<h1>Success! Count was: "
            , TL.pack $ show newInteger
            , "</h1>"
            ]


main :: IO ()
main = do
  [prefixArg] <- getArgs
  counter <- newIORef M.empty
  let config = undefined
      runR = undefined
  scottyT 3000 runR app

