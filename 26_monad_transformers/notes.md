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

If you want to use the transformer ("MonadT") variant of some monad **as if it were the original monad**, you can do so by applying it to a monad type that does nothing. **Identity** is just such a type.

Why would we need to do this? For many types of transformers, you don't. Some transformer types don't have a corresponding non-transformer to use, though. Plugging in Identity lets you quickly make your own in a situation like that. A concrete example of using **ReaderT Identity** when you need Reader-like functionality and you are working in the scotty framework.

Other info: the **transformers** library and **base** have high quality monad transformers, so don't make your own without a good reason.

If you ever see EitherT from the either library in the wild, bear in mind that people are phasing it out for the ExceptT type in **transformers**.

### 26.8 Lexically Inner is Structurally Outer

