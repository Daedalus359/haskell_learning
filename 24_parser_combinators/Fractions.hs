{-# LANGUAGE OverloadedStrings #-}

module Text.Fractions where

import Control.Applicative
import Data.Attoparsec.Text (parseOnly)
import Data.Ratio ((%))
import Data.String (IsString)
import Text.Trifecta

badFraction :: IsString s => s
badFraction = "1/0"

alsoBad :: IsString s => s
alsoBad = "10"

shouldWork :: IsString s => s
shouldWork = "1/2"

shouldAlsoWork :: IsString s => s
shouldAlsoWork = "2/1"

parseFraction :: (Monad m, TokenParsing m) => m Rational
parseFraction = do
  --decimal is a TokenParsing m => m Integer
  --numerator gets an Integer out of decimal
  numerator <- decimal
  --parse '/' but do nothing with it
  char '/'
  --same as with numerator
  denominator <- decimal
  --build the ratio and return it in the context of a Parser
  case denominator of
    0 -> fail "Denominator cannot be zero"
    _ -> return (numerator % denominator)

--modify the parser to fail when it parses a zero denominator
virtuousFraction :: Parser Rational
virtuousFraction = do
  numerator <- decimal
  char '/'
  denominator <- decimal
  case denominator of
    0 -> fail "Denominator should not be zero"
    _ -> return (numerator % denominator)



main :: IO ()
main = do
  let parseFraction' = parseString parseFraction mempty
  print $ parseFraction' shouldWork
  print $ parseFraction' shouldAlsoWork
  
  --will fail because it doesn't find '/'
  print $ parseFraction' alsoBad

  --fails to parse because we made a parser that does not accept zero denominators
  print $ parseString virtuousFraction mempty badFraction

  --parses, but fails when trying to construct a ratio with zero denominator
  print $ parseFraction' badFraction

  putStrLn "new examples for 24.9: Polymorphic Parsers"
  let attoP = parseOnly parseFraction

  putStrLn "Attoparsec parses"
  print $ attoP badFraction
  print $ attoP shouldWork
  print $ attoP shouldAlsoWork
  print $ attoP alsoBad

  putStrLn "Trifecta parses"
  let p f i = parseString f mempty i

  print $ p parseFraction badFraction
  print $ p parseFraction shouldWork
  print $ p parseFraction shouldAlsoWork
  print $ p parseFraction alsoBad
