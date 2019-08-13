# Nonstrictness

### Intro

Haskell evaluates expressions in an "outside in" fashion, so a computation can stop before every detail of the data being operated over has been examined. As a result, some functions can work over data that contains undefined / bottom values.

### Seq and forcing evaluations

seq :: a -> b -> b

From the polymorphism shown here, it is clear that the value resulting from seq aVal bVal is bVal. In other words, seq a b = flip const a b.

The key is that when seq's first argument is bottom, the result is bottom. In any other case, that first argument is completely discarded.

### Forcing Evaluation with Pattern Matching

data Test =
    A Test2
  | B Test2

data Test2 =
    C Int
  | D Int

forceNothing _ = 0
forceTest (A _ ) = 1
..
forceTest2 (A (C i))

forceNothing will never bottom out based on undefined Test values. forceTest will succeed as long as there is at least a well defined Test data constructor. forceTest2 requires every value down to the integer at the core to be evaluated.

### Call By Name, Call By Need

Evaluation strategies can be dividedd along the following lines:

1 - call by value evaluates every expression before entering a function
2 - call by name allows passing unevaluated expressions to functions
3 - call by need is like call by name, except that expressions get evaluated only once

### Sharing the results of computations

Debug.Trace is a module in base that has functions, including trace, that can be used to observe sharing by GHC for efficiency purposes

See HowManyTimes.hs for demos of trace that show how sharing can be promoted by the way code is written

You can promote sharing by giving names to your computations, and using the name when you want the result of that computation (common sense)

Polymorphic functions reduce sharing, so forcing monomorphism when you know it's appropriate (e.g. annotating Integer types when using integer literals)

### Refutable and Irrefutable Patterns

When pattern matching, an irrefutable pattern is one which will never fail to match

The following matches on an irrefutable pattern:

myFunc :: Bool -> Bool
myFunc x = not x

Whereas this uses refutable patterns

myFunc False = True
myFunc True = False

And this last one uses one of each

myFunc True = False
myFunc _ = True

you  can make patterns **lazy** by adding a tilde to the front

lazyPattern :: (a, b) => String
lazyPattern \~(a, b) = const "Cousin it" a

**lazy patterns are always irrefutable**

### Bang patterns

the {-# LANUGAGE BangPatterns #-} pragma lets patterns become strict with !, just like ~ made them lazy

if your code has a lot of Int values floating around, it can be helpful to take advantage of this

making a thunk for each of 1000000 Int values is much less efficient than computing each one as you go

