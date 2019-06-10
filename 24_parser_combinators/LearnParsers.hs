module LearnParsers where

import Text.Trifecta
import Control.Applicative

stop :: Parser a
stop = unexpected "stop"

one = char '1'
one' = one >> stop

oneTwo = char '1' >> char '2'

oneTwo' = oneTwo >> stop

--Exercises: Parsing Practice

--1 I'm not sure I understood the instructions properly, but this is valid Haskell
oneTwoEof = char '1' >> eof >> char '2'

--2 
p123 :: String -> IO ()
p123 str = testParseStr $ string str

testParseStr :: Parser String -> IO ()
testParseStr p = print $ parseString p mempty "123"

testParse :: Parser Char -> IO ()

testParse p = print $ parseString p mempty "123"

--3: proud of this one
stringFromChar :: (Monad m, CharParsing m) => String -> m String
stringFromChar "" = return ""
stringFromChar (c : cs) = liftA2 (:) (return c) $ stringFromChar cs

pNL s = putStrLn ('\n' : s)

main = do
  pNL "stop:"
  testParse stop
  pNL "one:"
  testParse one
  pNL "one':"
  testParse one'
  pNL "oneTwo:"
  testParse oneTwo
  pNL "oneTwo':"
  testParse oneTwo'
  pNL "oneTwoEof:"
  testParse oneTwoEof
  pNL "testParseStr with real string"
  testParseStr $ string "123"
  pNL "testParseStr with custom string:"
  testParseStr $ stringFromChar "123"

