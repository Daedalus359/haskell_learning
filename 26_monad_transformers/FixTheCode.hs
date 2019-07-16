module FixTheCode where

import Control.Monad.Trans.Maybe
import Control.Monad

isValid :: String -> Bool
isValid v = '!' `elem` v

maybeExcite :: MaybeT IO String
maybeExcite = MaybeT $ do
  v <- getLine
  maybeE <- return (guard $ isValid v :: Maybe ())
  return (fmap (\x -> v) maybeE)

--the authors actually wrote these strings, I swear
doExcite :: IO ()
doExcite = do
  putStrLn "say something excite!"
  excite <- runMaybeT maybeExcite --excite :: Maybe String
  case excite of
    Nothing -> putStrLn "MOAR EXCITE"
    Just e ->
      putStrLn ("Good, that was very excite: " ++ e)