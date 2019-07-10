# 25 - Composing Types

Subject of this chapter and the next - Monad Transformers

Functors and Applicatives are closed under composition:
	instance (Functor f1, Functor f2) => Functor (f1 f2) --not totaly sure I got the syntax right here
	instance (Applicative f1, Applicative f2) => Applicative (f1 f2)

Monads are not closed under composition, meaning that composing type monads *might* not result in another monad. It will result in a type which is still a Functor and an Applicative, per the above laws.

Composing monads allows for building up computations that have a variety of effects. Combining Maybe and IO lets you build up a computation that does IO and may also fail (for reasons not related to the IO -- my assumption).

