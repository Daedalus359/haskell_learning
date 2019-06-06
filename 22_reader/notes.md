# Reader

### Definition
newtype Reader r a =
  Reader { runReader :: r -> a}

reader is a newtype wrapper for the function type

### Functor of Functions

the Functor of a function is composition:

instance Functor ((->) a) where
  fmap = (.)

the functor instance for reader composes a function with the one wrapped inside. This is just like a regular function without a wrapper

### Applicative of Functions

Functions have an instance of applicative:

pure 'a' :: (a -> Char) creates a function that always returns 'a' for any input argument
pure seems to just be 'const' for this case

specialize the type of (<*>) for ((->) r)
(<*>) :: (r -> a -> b) -> (r -> a) -> (r -> b)
--the following is my guess for how that works in practice
(<*>)    fab               fa         fb        r = fab r (fa r) --(<*>) so markdown doesn't whine at me

### Monad of Functions

--my GUESS
instance Monad ((->) a) where
  (>>=) faz fzfab = (\a -> fzfab $ faz a)

### Thughts

The purpose of Reader seems unclear to me at this point. It doesn't seem to let you do anything that can't already be done on a function directly.