# 25 - Composing Types

Subject of this chapter and the next - Monad Transformers

Functors and Applicatives are closed under composition:
	instance (Functor f1, Functor f2) => Functor (f1 f2) --not totaly sure I got the syntax right here
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

