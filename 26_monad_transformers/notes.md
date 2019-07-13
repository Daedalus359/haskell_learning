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

Note that in the transformer instances, the monad parameter m winds up on the **outside** of whatever base monad type corresponds to the transformer. For example:

newtype EitherT e m a =
  EitherT {runEitherT :: m (Either e a)}

Note that EitherT is the outermost type constructor, but the value has Either inside m. This pattern is necessary to how transformers work. In some cases, part of the base monad type still winds up on the outside. For example:

newtype ReaderT r m a =
  ReaderT {runReaderT :: r -> m a}

The explanation offered here is that the monad m gets wrapped around things we "have" (m a, I guess), rather than things we "need" (r?).

Haskellers usually call the structurally outermost type the **base monad**. For example the base monad is IO in the following:

type MyType a = IO [Maybe a]

### 26.9 MonadTrans

fmap, liftA, and liftM all do the same thing: they *lift* a function into a higher context.

For some other lifting needs, we have the **MonadTrans** typeclass:

class MonadTrans t where
  lift :: (Monad m) => m a -> t m a

This is somewhat like return / pure, except that it puts an entire monad into your MonadTrans-implementing type. See EitherT.hs and StateT.hs for implementation example exercises. My approach to both exercises was derived from looking at my pure instances for those same types.

Some (**bad**) code puts together a monad transformer stack from a low-level monad one layer at a time, resulting in expressions that include "lift $ lift $ lift $ ... ". Don't do that. Rather, write a newtype which hides away all of the transformer layers in your type. Then, you can put a type in with a single **lift**.

Why not just put that monad type inside with a single **return**? Return does not involve the value it accepts into the chain of Monads in your transformer stack. As a result, you data would be the wrong shape, and you would need to lift in functions that operate on an (m a) rather than just putting in the functions on a that you probably want to use, as that's a big part of what makes monad transformers useful in the first place.

### 26.10 MonadIO aka zoom-zoom

MonadIO is another typeclass that provides a similar kind of functionality to MonadTrans, but it helps you to automatically lift to an outermost IO layer (via a **liftIO** function) all at once.

For example, you could use liftIO to do IO in the following contexts:

liftIO :: IO a -> StateT s IO a --not too hard to do with MonadTrans
liftIO :: IO a -> --now you are saving some time
       -> ExceptT
            e
            (StateT s (ReaderT r IO))
            a

Here is the typeclass definition:

class Monad m => MonadIO m where
  liftIO :: IO a -> m a

Here are some laws that a good instance should obey:
  1. liftIO . return = return
  2. liftIO (m >>= f) = liftIO m >>= (liftIO . f)

2 seems to be saying that the behavior of your IO interactions should be preserved which side of the lifting those interactions happen on.

How can liftIO do this? Looking at the example instances listed, it seems that you need to have liftIO instances for your monad parameters as well. Then, liftIO instances happen by calling liftIO to the next level down and then composing that with an operation (such as lift) that gets you up the last level of structure:

instance (MonadIO m) => MonadIO (IdentityT m) where
  liftIO = IdentityT . liftIO

instance (MonadIO m) => MonadIO (EitherT e m) where
  liftIO = lift . liftIO

see MaybeT.hs, ReaderT.hs, and StateT.hs for implementations of MonadIO I did as exercises there.

### 26.11 Monad transformers in use