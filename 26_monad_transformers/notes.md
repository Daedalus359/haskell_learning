# Chapter 26 - Monad Transformers

### 26.1 Intro and Agenda

This chapter covers practical uses of Monad transformers.

Agenda:
* look at some instances of Monad Transformers
* look at how some "stacks" of Monad Transformers work

### 26.2 MaybeT, 26.3 EitherT

While IdentityT does have practical applications (details to come), MaybeT will be introduced as a more compelling instance of a Monad transformer.

See MaybeT.hs

Something important that IdentityT doesn't make clear is that these "MonadT" types are putting their namesake monad **inside** the polymorphic monad type
For examples of this, see MaybeT.hs and EitherT.hs

### 26.4 ReaderT

See ReaderT.hs for the typeclass implementation exercises.

Apparently, the Writer and WriterT types are bad.

Compare the following:

newtype StateT s m a =
  StateT {runStateT :: s -> m (a, s)}

type Parser a = String -> Maybe (a, String)

to get a feeling for what State can do, consider that we could make a functionally equivalent type to Parser like this:

type Parser = StateT String Maybe

### Types you probably don't want to use

**WriterT and Writer** are usually not at the sweet spot of strict / laziness people need. I don't yet understand what this means.

"Thunks" are mentioned in passing in that explanation. More detail on them is at:
https://wiki.haskell.org/Thunk

https://www.microsoft.com/en-us/research/wp-content/uploads/1992/04/spineless-tagless-gmachine.pdf

A Thunk is an unevaluated value.

The obvious way to implement **ListT** is also bad, as it has several issues with lawfulness and speed. Libraries like pipes and conduit supposedly do this job well.

### 26.7 An ordinary type from a transformer