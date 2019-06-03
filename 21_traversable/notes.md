# Traversable

### Typeclass definition:
class (Functor t, Foldable t) => Traversable t where
  traverse :: Applicative f => (a -> f b) -> t a -> f (t b)
  sequenceA :: Applicative f => t (f a) -> f (t a)

### sequenceA

sequenceA flips structure around:

Prelude> sequenceA [Just 1, Just 2]
Just [1,2]

Prelude> sequenceA [Just 1, Nothing]
Nothing

### traverse

comparing this to some known functions:

fmap :: Functor f =>                          (a -> b)   -> f a -> f b
(=<<) :: Monad m =>                           (a -> m b) -> m a -> m b
traverse :: (Traversable t, Applicative f) => (a -> f b) -> t a -> f (t b)

Consider functions from the Morse code exercise:
charToMorse :: Char -> Maybe Morse
stringToMorse :: String -> Maybe [Morse]
stringToMorse = traverse charToMorse --a is char, f is Maybe, b is Morse, t is []. Thus, f (t b) is Maybe [Morse]

### traversable laws

t . traverse f = traverse (t . f)
traverse Identity = Identity
