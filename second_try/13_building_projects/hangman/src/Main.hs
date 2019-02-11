module Main where

import Control.Monad (forever)
import Data.Char (toLower)
import Data.Maybe (isJust)
import Data.List (intersperse)
import System.Exit (exitSuccess)
import System.Random (randomRIO)
import System.IO

type WordList = [String]

minWordLength :: Int
minWordLength = 5

maxWordLength :: Int
maxWordLength = 9

maxWrongGuesses :: Int
maxWrongGuesses = 5

allWords :: IO WordList
allWords = do
    dict <- readFile "data/words"
    return (lines dict)

gameWords :: IO WordList
gameWords = do
    aw <- allWords
    return (filter gameLength aw)
    where
        gameLength :: String -> Bool
        gameLength w =
            let l = length (w :: String)
            in  l >= minWordLength && l <= maxWordLength

randomWord :: WordList -> IO String
randomWord wl = do
    randomIndex <- randomRIO (0, (length wl - 1))
    return $ wl !! randomIndex

randomWord' :: IO String
randomWord' = gameWords >>= randomWord

data Puzzle =
    Puzzle String [Maybe Char] [Char]

instance Show Puzzle where
    show (Puzzle _ discovered guessed) =
        (intersperse ' ' $ fmap renderPuzzleChar discovered)
        ++ " Guessed so far: " ++ guessed

freshPuzzle :: String -> Puzzle
freshPuzzle str = Puzzle str (take (length str) (repeat Nothing)) []

renderPuzzleChar :: Maybe Char -> Char
renderPuzzleChar Nothing = '_'
renderPuzzleChar (Just c) = c

charInWord :: Puzzle -> Char -> Bool
charInWord (Puzzle word _ _) c = elem c word

alreadyGuessed :: Puzzle -> Char -> Bool
alreadyGuessed (Puzzle _ _ guessed) c = elem c guessed

fillInCharacter :: Puzzle -> Char -> Puzzle
fillInCharacter (Puzzle word filledInSoFar s) c =
    Puzzle word newFilledInSoFar (c : s)

    where   zipper guessed wordChar guessChar =
                if wordChar == guessed then Just wordChar else guessChar

            newFilledInSoFar = zipWith (zipper c) word filledInSoFar

handleGuess :: Puzzle -> Char -> IO Puzzle
handleGuess puzzle guess = do
    putStrLn $ "Your guess was: " ++ [guess]
    case (charInWord puzzle guess, alreadyGuessed puzzle guess) of
        (_, True) -> do
            putStrLn "You already guessed that, try again."
            return puzzle
        (True, _) -> do
            putStrLn "Good guess! Filling in the word."
            return (fillInCharacter puzzle guess)
        (False, _) -> do
            putStrLn "This character is not in the word. Try again."
            return (fillInCharacter puzzle guess)

tooManyGuesses :: Puzzle -> Bool
tooManyGuesses (Puzzle _ filledIn guesses)
  | wrongGuesses >= maxWrongGuesses = True
  | otherwise = False
    where
      wrongGuesses = (length guesses) - (length $ filter isJust filledIn)

gameOver :: Puzzle -> IO ()
gameOver pz@(Puzzle wordToGuess filledIn guessed) =
    if (tooManyGuesses pz) then
        do
            putStrLn "Max guesses taken, you lose."
            putStrLn $ "The word was: " ++ wordToGuess
            exitSuccess
    else return ()

gameWin :: Puzzle -> IO ()
gameWin (Puzzle _ filledInSoFar _) =
    if all isJust filledInSoFar then do
        putStrLn "You win!"
        exitSuccess

    else return ()

runGame :: Puzzle -> IO ()
runGame puzzle = forever $ do
    gameWin puzzle
    gameOver puzzle
    putStrLn $ "Puzzle: " ++ show puzzle
    putStr "Guess a letter: "
    guess <- getLine
    case guess of
        [c] -> handleGuess puzzle c >>= runGame
        _ -> putStrLn "Your guess must be a single character"

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  word <- randomWord'
  let puzzle = freshPuzzle (fmap toLower word)
  runGame puzzle