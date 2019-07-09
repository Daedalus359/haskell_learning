module Exercises where

import Text.Trifecta
import Control.Applicative
import Data.Maybe

--Ex 1
--parser for semantic versions as defined by http://semver.org/

data NumberOrString =
    NOSString String
  | NOSInt Integer
  deriving (Eq, Show)

type Major = Integer
type Minor = Integer
type Patch = Integer
type Release = [NumberOrString]
type Metadata = [NumberOrString]

data SemVer = SemVer Major Minor Patch Release Metadata
  deriving (Eq, Show)

--for whatever reason, this got tacked on to the exercise
instance Ord SemVer where
  (SemVer major1 minor1 patch1 _ _) `compare` (SemVer major2 minor2 patch2 _ _) =
    case (compare major1 major2) of
      GT -> GT
      LT -> LT
      EQ -> case (compare minor1 minor2) of
        GT -> GT
        LT -> LT
        EQ -> (compare patch1 patch2)

--change this to parse the right datatype later
parseNOS' :: Parser Integer
parseNOS' = do
  i <- natural
  return i

parseNOS :: Parser NumberOrString
parseNOS = (NOSInt <$> natural) <|> (NOSString <$> (some letter))

parseSemVer :: Parser SemVer
parseSemVer = do
  major <- natural <* (char '.')
  minor <- natural <* (char '.')
  patch <- natural <* (optional $ char '.')
  release <- optional $ (char '-') *> (sepEndBy1 parseNOS (char '.'))
  metadata <- optional $ (char '-') *> (sepEndBy1 parseNOS (char '.'))
  return $ SemVer major minor patch (fromMaybe [] release) (fromMaybe [] metadata)

main1 :: IO ()
main1 = do
  print $ parseString parseSemVer mempty "1.2.3"
  print $ parseString parseSemVer mempty "1.2.3."
  print $ parseString parseSemVer mempty "1.2.3-4"
  print $ parseString parseSemVer mempty "1.2.3-4-5"
  print $ parseString parseSemVer mempty "1.2.3-4.5-5.6"
  print $ parseString parseSemVer mempty "1.2.3-4.5.asd-ghj"
  putStrLn "the following should fail"
  print $ parseString parseSemVer mempty "1.2.3--5"
  print $ parseString parseSemVer mempty "1.2.3-4-"

--Ex4
type AreaCode = Int
type Exchange = Int
type LineNumber = Int

data PhoneNumber = PhoneNumber AreaCode Exchange LineNumber
  deriving (Eq, Show)

parsePhone :: Parser PhoneNumber
parsePhone = do
  --get rid of the single digit leading number, if present
  _ <- optional $ try $ digit >> choice [char '-', char ' ']
  ac <- optional (char '(') *> (count 3 digit) <* (optional (char ')')) <* (optional (choice $ fmap char ['-', ' ']))--ac :: [char]
  exch <- (count 3 digit) <* (optional (choice $ fmap char ['-', ' ']))
  linNum <- (count 4 digit)
  return $ PhoneNumber (read ac) (read exch) (read linNum)

main4 :: IO ()
main4 = do
  let p s = print $ parseString parsePhone mempty s
  p "123-456-7890"
  p "1234567890"
  p "(123) 456-7890"
  p "1-123-456-7890"

--Ex5
type Year = Integer
type Month = Integer
type Day = Integer

data Date = Date Year Month Day
  deriving (Show)

parseDate :: Parser Date
parseDate = do
  year <- string "# " *> natural <* (char '-')
  month <- natural <* (char '-')
  day <- natural
  return $ Date year month day

type Hour = Integer
type Minute = Integer
data Time = Time Hour Minute
  deriving (Show)

data Activity = Activity Time String
  deriving (Show)

--modify to ignore trailing comments
parseActivity :: Parser Activity
parseActivity = do
  hour <- natural <* (char ':')
  minute <- natural <* spaces
  actString <- some anyChar
  return $ Activity (Time hour minute) actString

main5 :: IO ()
main5 = do
  let ps p s = print $ parseString p mempty s
  ps parseDate "# 2025-02-05"
  ps parseActivity "09:00 Sanitizing moisture collector"