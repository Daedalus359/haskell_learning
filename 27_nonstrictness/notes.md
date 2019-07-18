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

