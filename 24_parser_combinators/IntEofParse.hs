module IntEofParse where

--24.4 Exercise

import Text.Trifecta

intEofParse :: TokenParsing m => m Integer
intEofParse = integer <* eof

main :: IO ()
main = print $ parseString intEofParse mempty "123"
