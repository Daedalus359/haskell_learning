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

