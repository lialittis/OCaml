# Monad

## What is Monad

About this part, please go to the repo of Functional Programming/Haskell.

## Definition

The more common definition for a monad in functional programming is actually 
based on a Kleisli triple rather than category theory's standard definition. 
The two constructs turn out to be mathematically equivalent, however, so either 
definition will yield a valid monad. Given any well-defined, basic types T, U, 
a monad consists of three parts:

- A type constructor M that builds up a monadic type M T[b]

- A type converter, often called unit or return, that embeds an object x in the monad:

unit(x) : T → M T[c]

- A combinator, typically called bind (as in binding a variable) and represented
with an infix operator >>=, that unwraps a monadic variable, then inserts it into 
a monadic function/expression, resulting in a new monadic value:

(mx >>= f) : (M T, T → M U) → M U[d]

To fully qualify as a monad though, these three parts must also respect a few laws:

unit is a left-identity for bind:

unit(a) >>= λx → f(x) ↔ f(a)

unit is also a right-identity for bind:

ma >>= λx → unit(x) ↔ ma

bind is essentially associative:[e]

ma >>= λx → (f(x) >>= λy → g(y)) ↔ (ma >>= λx → f(x)) >>= λy → g(y)

Algebraically, this means any monad both gives rise to a category (called the 
Kleisli category) and a monoid in the category of functors (from values to 
computations), with monadic composition as a binary operator and unit as identity.

### return

return is one of the 3 components to qualify as a monad, it is thus usd to "send" 
a value inside a monad. There's no need to do that without a good reason, but, 
for example, you may choose to embed a function inside the Error monad instead of 
throwing exceptions for errors and non-monadic values for succesful computations. 

[About Tezos] The main drawback of monadic code is that it can of invade the rest
of your components. It's usually not a real issue inside the Tezos codebase since
it already "infected" by monads.

"return" is not a keyword, it is a definition.




