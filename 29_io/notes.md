# IO

### IO is Not State or ST

The types of State and IO and State look similar:

newtype State s a = State {runState :: s -> (a, s)}

newtype IO a  = IO (State# RealWorld -> (# State# RealWorld, a #))

note that the # symbol on State# indicates that it is a primitive type. Digging through docs reveals that RealWorld and State# are completely erased by runtime - there is no representation of State# values for us to interact with in the context of IO

### Why IO is Necessary

IO turns off a lot of GHC's normal tendencies to reorder things, mess with how evaluation is performed, and other operations that would mess up the kind of stuff we want to accomplish when doing IO.

IO Makes sure that things get operated in a particular order

an "IO a" value can sometimes be thought of as a set of instructions for getting a value of type a, as in:

getCurrentTime :: IO UTCTime

The consequence of this is that getCurrentTime doesn't use sharing, in the sense that it doesn't just fetch a previously determined time if the expression has been evaluated before.

In other words, the point of IO is that you evaluate it by following the instructions it contains.

### Note on Purity and Referential Transparency

Functions that return some **IO a** value are still referentially transparent, even if it is something like a random number generator that will cause different behavior every time it is executed. This is because the function itself returns the recipe, and the recipe is always the same for a given input.

### Functor, Applicative, and Monad instances

IO is more than just a Monad - like all other monads, it is a datatype that just happens to have an instance of that typeclass.

**fmap**-ing over an **IO a** value results in an IO value that has the same effects, but transforms the 'a' type(s) inside

fmap (+1) (randomIO :: IO Int)

**(<\*>)** performs the effects of both the function (left operand) and its right operand, then applies the function to the value

Prelude> (++) <$> getLine <\*> getLine
hello
julie
"hellojulie"

(+) <$> (randomIO :: IO Int) <\*> (randomIO :: IO Int)

**pure / return** are functions that take a value and put it into the IO context, effectively describing a recipe that just instructs you to take the value that was passed to pure

**join** merges the effects of a nested IO action. In the recipe metaphor, IO (IO a) is like a recipe that, in turn, makes a recipe for a. Join basically turns this into a recipe in which you follow the outer recipe to create the inner recipe, then follow the inner recipe to create some **a** value

### Don't confuse Contructing IO actions with executing them

This insight covers a lot of the above notes. All of your Haskell code amounts to a construction of one big IO action (main), which GHC understands and uses to generate a runnable program.

### Exercises

See VigenereIO, in which I do none of the Vigenere part but try to get the equivalent IO functionality in place.
run instructions:
* make sure reverseThese.txt (or any file with 5+ lines of text, replace stdin direction with it) is handy
* compile: stack ghc -- -O2 VigenereIO.hs
* run: ./VigenereIO a b c d < reverseThese.txt
* run: ./VigenereIO type in some inputs and press enter