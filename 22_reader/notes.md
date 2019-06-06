# Reader

newtype Reader r a =
  Reader { runReader :: r -> a}

reader is a newtype wrapper for the function type

the functor instance for reader composes a function with the one wrapped inside. This is just like a regular function without a wrapper

Functions have an instance of applicative:

pure 'a' :: (a -> Char) creates a function that always returns 'a' for any input argument
pure seems to just be 'const' for this case

specialize the type of (<*>) for ((->) r)
(<*>) :: (r -> a -> b) -> (r -> a) -> (r -> b)
--the following is my guess for how that works in practice
(<*>)    fab               fa         fb        r = fab r (fa r)