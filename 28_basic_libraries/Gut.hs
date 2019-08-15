module Main where

import Control.Monad
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import qualified System.IO as SIO

import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.IO as TLIO

wordsLoc = "/usr/share/dict/words"

dictWords :: IO String
dictWords = SIO.readFile wordsLoc

dictWordsT :: IO T.Text
dictWordsT = TIO.readFile wordsLoc

dictWordsTL :: IO TL.Text
dictWordsTL = TLIO.readFile wordsLoc

main :: IO ()
main = do
  replicateM_ 100 (dictWords >>= print)
  replicateM_ 100 (dictWordsT >>= TIO.putStrLn)
  replicateM_ 100 (dictWordsTL >>= TLIO.putStrLn)