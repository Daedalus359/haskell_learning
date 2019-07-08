{-# LANGUAGE OverloadedStrings #-}
--OverLoadedStrings lets us make String literals in our source code, then run them as ByteStrings in our code

module BT where

import Control.Applicative
import qualified Data.Attoparsec.ByteString as A
import Data.Attoparsec.ByteString (parseOnly)

import Data.ByteString (ByteString)
import Text.Trifecta hiding (parseTest)
import Text.Parsec (Parsec, parseTest)

trifP :: Show a => Parser a -> String -> IO ()
trifP p i = print $ parseString p mempty i

parsecP :: (Show a) => Parsec String () a -> String -> IO ()
parsecP = parseTest

attoP :: Show a => A.Parser a -> ByteString -> IO ()
attoP p i = print $ parseOnly p i

nobackParse :: (Monad f, CharParsing f) =>  f Char
nobackParse = (char '1' >> char '2') <|> char '3'

--try causes the cursor to return to its original location of the 1 2 part fails
tryParse :: (Monad f, CharParsing f) => f Char
tryParse = try (char '1' >> char '2') <|> char '3'

--try can make understanding the error messages harder. Using <?> helps here
tryAnnot :: (Monad f, CharParsing f) => f Char
tryAnnot = (try (char '1' >> char '2') <?> "Tried 12") <|> (char '3' <?> "Tried 3")

main :: IO ()
main = do
  --trifecta
  putStrLn "trifecta noback"
  trifP nobackParse "13"
  putStrLn "trifecta try"
  trifP tryParse "13"
  --parsec
  parsecP nobackParse "13"
  parsecP tryParse "13"
  --attoparsec
  attoP nobackParse "13"
  attoP tryParse "13"