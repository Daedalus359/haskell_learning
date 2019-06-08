# State

### Intro

The State type in Haskell is a means of expressing state that may change in the course of evaluating code without resort to mutation.

State does not provide in place mutation. For that, see ST.

Using the State type lets us represent state that
* doesn't require IO
* is limited only to the data in the State container
* maintains referential transparency
* is explicit in the types of our functions

State is appropriate when you want to express your program in terms of values that potentially vary with each evaluation step, which can be read and modified, but don't otherwise have specific operational constraints.

### Example: Random Numbers

System.Random is designed to generate pseudorandom values. You can generate those values through providing a seed value or by using the system-initialized generator.

### The State Newtype

newtype State s a =
  State {runState :: s -> (a, s)}


