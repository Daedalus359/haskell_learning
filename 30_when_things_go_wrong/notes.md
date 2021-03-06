### GADTs

GADTs and existential quantification let you create heterogeneous datatypes

    data IsShowable = forall s . Show s => IsShowable s

    instance Show IsShowable where
      show (IsShowable s) = show s

    hetList :: [IsShowable] 
    hetList = [IsShowable 1, IsShowable 'c', IsShowable (Nothing :: Maybe String)]

The following is an alternate syntax for GADTs:

    data IsShowable where 
      IsShowable :: (Show s) => s -> IsShowable

### Typeable

Typeable lets you run code that can determine the type of a value at runtime. This can be necessary because the use of existential quantification can prevent you from knowing the type of a value at compile time, as in a value that matches (IsShowable a), see above.

    cast :: (Typeable a, Typeable b) => a -> Maybe b

### Exceptions

Exceptions use the SomeException type to contain exception values that could be of any type with an instance of the exception typeclass:

    class (Typeable e, Show e) => Exception e where
      toException :: e -> SomeException
      fromException :: SomeException -> Maybe e
      displayException :: e -> String

    data SomeException = forall  e . Exception e => SomeException e

When there are numerous things that could go wrong with a program, it is useful to have a single type, SomeException rather than something like the following:

    data Result a = Correct a | Arith ArithError | OF OverflowError | ....

### Exception Handling

The catch function combines some code capable of producing an exception with code that handles that exception in a particular way:

    ghci>import Control.Exception
    ghci>:i catch
    catch :: Exception e => IO a -> (e -> IO a) -> IO a

The second argument to catch is your error handling function, and `catch` only runs this function if an error of the righr type is produced. Using a handler that works for values of type `SomeException` lets you handle heterogeneous exceptions.

