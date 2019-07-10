{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Exercises where

import Text.Trifecta
import Control.Applicative
import Data.Maybe

import Data.ByteString (ByteString)
import Text.RawString.QQ

import Test.QuickCheck

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
  deriving Eq

instance Arbitrary Date where
  arbitrary = liftA3 Date (elements [1000 .. 3000]) (elements [1..12]) (elements [1..31])

instance Show Date where
  show (Date year month day) = "# " ++ (show year) ++ "-" ++ (formatStr month) ++ "-" ++ (formatStr day)
    where
      formatStr t = if (t > 9) then (show t) else ('0' : (show t))

parseDate :: Parser Date
parseDate = do
  year <- string "# " *> natural <* (char '-')
  month <- natural <* (char '-')
  day <- natural
  return $ Date year month day

type Hour = Integer
type Minute = Integer
data Time = Time Hour Minute
  deriving (Eq)

instance Arbitrary Time where
  arbitrary = liftA2 Time (elements [0 .. 23]) (elements [0 .. 59])

resultToMaybe :: Text.Trifecta.Result a -> Maybe a
resultToMaybe (Text.Trifecta.Failure _) = Nothing
resultToMaybe (Text.Trifecta.Success a) = Just a

propTimeParses :: Time -> Bool
propTimeParses t = Just t == (resultToMaybe $ parseString parseTime mempty $ show t)

--just for QuickCheck exercise - not used in the Journal parser
parseTime :: Parser Time
parseTime = liftA2 Time integer (char ':' *> integer)

instance Show Time where
  show (Time hour minute) = (timeStr hour) ++ ":" ++ (timeStr minute)
    where
      timeStr t = if (t > 9) then (show t) else ('0' : (show t))

data Activity = Activity Time String
  deriving Eq

instance Show Activity where
  show (Activity time string) = show time ++ " " ++ (show string)

instance Arbitrary Activity where
  arbitrary = liftA2 Activity arbitrary (elements [1..30] >>= (\i -> fmap (take i) $ fmap (filter (\c -> elem c ['a' .. 'z'])) infiniteList))

--modify to ignore trailing comments
parseActivity :: Parser Activity
parseActivity = do
  hour <- natural <* (char ':')
  minute <- natural <* spaces
  actString <- manyTill anyChar $ (try skipEOL) <|> (try skipComment) <|> eof
  return $ Activity (Time hour minute) actString

skipEOL :: Parser ()
skipEOL = do
  string "\n"
  return ()

skipComment :: Parser ()
skipComment = do
  choice [string "--", string " --"]
  manyTill anyChar $ (try $ skipSome $ string "\n") <|> eof
  return ()

skipSpace :: Parser ()
skipSpace = do
  char ' '
  return ()

skipJunk :: Parser ()
skipJunk = try $ choice [skipSpace, skipEOL, skipComment] <?> "Skipjunk expects a space, end of line, or comment"

data DayLog = DayLog Date [Activity]
  deriving Eq

instance Show DayLog where
  show (DayLog date activities) =
    show date ++ "\n" ++ vertActs
      where vertActs = concat $ fmap (++ "\n") $ fmap show activities 

instance Arbitrary DayLog where
  arbitrary = liftA2 DayLog arbitrary ((elements [1..10]) >>= (\i -> fmap (take i) (infiniteList :: Gen [Activity])))

--does not support lines which are just comments in the middle of the Day Log
parseDayLog :: Parser DayLog
parseDayLog = do
  date <- (many skipJunk <?> "Failed at skipjunk") *> (parseDate <?> "Failed at Parse Date")
  activityResults <- some $ many skipJunk *> parseActivity <?> "Failed at Parse Activity"
  return $ DayLog date activityResults

data Journal = Journal [DayLog]
  deriving Eq

instance Show Journal where
  show (Journal dayLogs) = concat $ fmap (++ "\n") $ fmap show dayLogs  

instance Arbitrary Journal where
  arbitrary = Journal <$> ((elements [1..10]) >>= (\i -> fmap (take i) (infiniteList :: Gen [DayLog])))

parseJournal :: Parser Journal
parseJournal = Journal <$> (some parseDayLog)

propJournalParses :: Journal -> Bool
propJournalParses j = Just j == (resultToMaybe $ parseString parseJournal mempty $ show j)

dayLogEx :: String
dayLogEx = [r|
--leading comment

--leading comment after whitespace
# 2025-02-05
09:00 Sanitizing Moisture Collector
--comment only line
09:30 second activity --comment
10:00 third activity--comment
|]

journalEx :: String
journalEx = [r|
--intro comment

# 1995-5-5
09:00 Eat Breakfast
--comment
10:00 eat dinner--comment

# 1996-5-5
09:00 Eat lunch
# 1997-5-5
12:30 Eat all meals at once --comment
|]

main5 :: IO ()
main5 = do
  let ps p s = print $ parseString p mempty s
  ps parseDate "# 2025-02-05"
  ps parseActivity "09:00 Sanitizing moisture collector\n"
  ps parseActivity "09:00 Sanitizing moisture collector --comment to be kept\n"
  ps skipComment "--this is a comment"
  ps parseDayLog dayLogEx
  ps parseJournal journalEx
  putStrLn "checking parsing on arbitrary Time instances"
  quickCheck propTimeParses
  putStrLn "checking parsing on arbitrary Journal instances"
  quickCheck propJournalParses
  --ps parseJournal pasted

pasted :: String
pasted = [r|# 2695-01-23
14:25 "ymwrghjvrqamtddadszzyosodt"
22:30 "gulhrmpiarptshadyvkhuochduuqj"
17:08 "kqaepugllokphftfw"
19:08 "fybcmejhjghmggnorbpt"
20:40 "novtajaiqkypkli"
10:31 "wjjqnxlbcryfnugwyrlwnpzbsoe"
11:05 "mtlpgiglezloxhmwypn"
20:43 "z"
04:42 "rhgbuxn"
04:14 "wnuogqjfhrytqybiiqxjnujy"
|]