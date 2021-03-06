# Applying Structure

Notes on various common uses for the typeclasses studied in the past few chapters.

## Monoids

See scotty.hs for code that generates a webpage which involves the use of monoids. The resulting page can be viewed at 127.0.0.1:3000/werd (etc.)

xmonad.hs relies on the following: instance Monoid b => Monoid (a -> b)

what this means: (f <> g) x = (f x) <> (g x)

## Functors

the offsetTime example fmaps a function of type UTCTime -> UTCTime (addUTCTime (offset * 24 * 3600)) over a type IO UTCTime

uuid.hs demonstrates fmap getting inside of IO that resulted from RNG

datatypes to describe web applications are (apparently) often Monads. This Monad often contains information associated with its type parameter, representing a result computed in the context of your web app. The included example apparently uses snap

## Applicative

(<*) :: Applicative f => fa -> f b -> f b
(*>) also exists
these functions are good for sequencing actions where you discard the result of one action. Often useful if you just want a computational effect but don't need a result.

applUtil.hs demonstrates the function Applicative (instance Applicative ((->) a))
specializing the types of liftA2 for this case gives
general:  liftA2 :: Applicative f => (a -> b -> c)       -> f        a    -> f        b ->    f             c
specific: liftA2 ::                  (Bool -> Bool -> c) -> ((->) a) Bool -> ((->) a) Bool -> ((->) (a)) -> Bool

appling liftA2 to (||) lets us drop the first input from the resulting type. The type signature above is a desugared version of what is in the source file:
(<||>) :: (a -> Bool) -> (a -> Bool) -> a -> Bool
(<||>) = liftA2 (||)

## Monad

Monad functions tend to appear in any code the uses IO

network.hs demonstrates do notation, but is missing a dependency I can't sort out

