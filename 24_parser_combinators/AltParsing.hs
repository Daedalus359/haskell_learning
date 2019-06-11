{-# LANGUAGE QuasiQuotes #-}

module AltParsing where

import Control.Applicative
import Text.RawString.QQ
import Text.Trifecta

type NumberOrString = Either Integer String

--eitherOr is effectively just another string.
--The QuasiQuotes functionality has been used to specify it.
eitherOr :: String
eitherOr = [r|
123
abc
456
def
|]

a = "blah"
b = "123"
c = "123blah789"

parseNos :: Parser NumberOrString
parseNos = skipMany (oneOf "\n") >>
  (Left <$> integer) <|> (Right <$> some letter)

main = do
  let p f i =
       print $ parseString f mempty i
  p (some letter) a
  p integer b
  p parseNos a
  p parseNos b
  p (many parseNos) c
  p (some parseNos) c
  p parseNos eitherOr