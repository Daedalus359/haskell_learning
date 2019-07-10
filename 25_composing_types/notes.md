# 25 - Composing Types

Subject of this chapter and the next - Monad Transformers

Functors and Applicatives are closed under composition:
	instance (Functor f1, Functor f2) => Functor (f1 f2) --not totaly sure I got the syntax right here
		--basically, (fmap . fmap) get all the way inside something of type (f g a) to apply a function of type (a -> b)
	instance (Applicative f1, Applicative f2) => Applicative (f1 f2)

Monads are not closed under composition, meaning that composing type monads *might* not result in another monad. It will result in a type which is still a Functor and an Applicative, per the above laws.

Composing monads allows for building up computations that have a variety of effects. Combining Maybe and IO lets you build up a computation that does IO and may also fail (for reasons not related to the IO -- my assumption).

A **Monad Transformer** is a variant of an ordinary type that takes an additional type argument which is assumed to have a monad instance.

Agenda for the chapter:
* demonstrate why composing two monads does not give you another monad
* maniuplate types to make monads compose
* meet some common monad transformers

### Identity

consider a new version of Identity:
newtype Identity a =
  Identity {runIdentity :: a}

in newtypes like the above, keywords like "run" (as in runIdentity) or "get" are usually a means of "extracting the underlying value from the type"

Note: there is a monad transformer version of Identity called IdentityT

Newtypes are appropriate for Monad transformers, because Monad transformers simply add an extra layer of monadic structure around a type. Newtypes can achieve this without adding runtime overhead.

Something to notice:
P> :t id
id :: a -> a
P> :k Identity
Identity :: * -> *

This suggests that runIdentity isn't meant to correspond to an identity. It's the type itself which is acting as an Identity.

### Compose

The compose type composes *at the type level:*

newtype Compose f g a =
  Compose {getCompose :: f (g a)}
  deriving (Eq, Show)

The kind of Compose:
Compose :: ( * -> * ) -> ( * -> * ) -> * -> *

Examples of values for the compose type:

P> Compose [Just 'a', Nothing]
Compose {getCompose = [Just 'a', Nothing]}

P> :t Compose [Just 'a', Nothing]
  :: Compose [] Maybe Char

looking at the newtype declarations, the corresponding types are
f ~ []
g ~ Maybe
a ~ Char

### Composing Functors

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance (Functor f, Functor g) => Functor (Compose f g) where --this means we need to be able to fmap types down to 
  fmap f (Compose fga) = Compose $ (fmap . fmap) f fga

this lets you do something like:
fmap (+1) (Compose [Just 1, Nothing])

whereas without Compose you would use (fmap . fmap) to explicitly go through one layer

This works for other types which take even more type parameters than Identity and Compose

The fact that the above instance (functor for Compose) exists is what makes *functors closed under composition*

### Composing Applicatives

Similar to the Functor instance, there is an instance of Applicative for Compose whenever its first two type parameters have instances of Applicative for themselves.

See ComposeInstances which can be used to run, for example:
Haskell> let a1 = Compose (Just [(+1), (+7)])
Haskell> let a2 = Compose $ Just [1,3]
Haskell> a1 <\*> a2 --the actual apply snytax messes with Markdown for some reason, so dont type a backslash if copying from plain text
Compose {getCompose = Just [2,4,8,10]}

### Composing Monads (or Trying, anyway)

It is **not possible** to write a generic Monad instance for (Compose f1 f2), even if we know that (Monad f1, Monad f2) holds.

We would need to write (>>=) :: Compose f g a -> (a -> Compose f g b) -> Compose f g b
Compose fga >>= aToCfgb = **???** --this is **impossible**. See http://web.cecs.pdx.edu/~mpj/pubs/RR-1004.pdf

The solution turns out to be **monad transformers**, coming next

