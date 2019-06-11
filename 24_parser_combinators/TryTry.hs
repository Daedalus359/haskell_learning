module TryTry where

import Text.Trifecta
import Control.Applicative
import Data.Ratio ((%))

--parseDecFrac :: Parser Rational
--parseDecFrac =
  --liftA2 (%) (decimal <* (skipMany $ char ('/'))) (try decimal)

data NumsToParse = Top Rational | Middle Double | Bottom Integer
  deriving Show

--parse numbers as an integer ratio
virtuousFraction :: Parser Rational
virtuousFraction = do
  numerator <- decimal
  char '/'
  denominator <- decimal
  case denominator of
    0 -> fail "Denominator should not be zero"
    _ -> return (numerator % denominator)


decimalParser :: Parser Double
decimalParser = do
  wholePart <- decimal
  decimalPart <- (try $ char '.' >> decimal)
  return ((fromIntegral wholePart) + ((fromIntegral decimalPart) / ((10 ^) . length . show $ decimalPart)))
  --return (fromIntegral wholePart)

parseIntDouble :: Parser (Either Integer Double)
parseIntDouble = (Right <$> (try decimalParser)) <|> (Left <$> decimal)

parseIntFrac :: Parser (Either Integer Rational)
parseIntFrac = (Right <$> (try virtuousFraction)) <|> (Left <$> decimal)

parseDecFrac :: Parser NumsToParse
parseDecFrac = (Top <$> (try virtuousFraction)) <|> 
                  ((Middle <$> (try decimalParser)) <|> 
                  (Bottom <$> decimal))

main :: IO ()
main = do
  print $ parseString parseDecFrac mempty "1/2"
  print $ parseString parseDecFrac mempty "23.5"
  print $ parseString parseDecFrac mempty "1"