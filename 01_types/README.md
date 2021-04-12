# How to run .ml file directly ? 

When we put <#!/usr/bin/ocaml> at the top of the .ml file, the .ml will be excutated.

# Function

## keyword "function"

$let add = function x y -> x+y;;

is equal with

$let add = fun x y -> x + y;;

## partial application

$let add x y = x + y;;

`$let incr = add 1;;` is equal with `$let incr y = add 1 y;;`

And `$let add = fun x y -> x+y` is equal with `$let add x = fun y -> x+y`


## recurive

Keyword: rec

Example of factorial function:

$let rec fact n = 
	if n = 0 then 1 else n * fact(n-1)


# Types
	
Types in OCaml are:

* static
* inferred: no type annotation is required
* polymorphic
* principal

## Booleans

The usual operators are : conjunction &&, disjunction ||, negation not, equality =, uneuqality <>.

They can be used in conditional branchings: `if...then...else` or `while ... do ... done`.

Beware that == and != also exist, but they compare values physically, i.e. check whether they have the same memory location, not if they have the same contents.

$ let x = ref 0;;
$ let y = ref 0;;

$ x = y;;

-: bool = true

$ x == y;;

-: bool = false

## Products

The pair of x and y is noted x,y. For instance, we can consider the pair 3,"hello" which has the product type `int*type`. 


## Usual recurisive types

It is interesting to note that many usual types can be encoded as recursive types.

Values of recurive types can be observed by **pattern matching**.

### Booleans

type bool = 
	|Ture 
	| False


### if
A case construction: `if b then e1 else e2` could then be encoded as

$ match b with 
	| True -> e1
	| False -> e2

### Natural numbers

type nat = 
	| Z
	| S of nat

### Addition

let rec add x y = 
	match x with
	| Z -> y
	| S x' -> S(add x' y)

### Unit

$ type unit=
	| T

which is usually written () instead of T

A function let f () = e can be written as

$ let f x=
	match x with
	| T -> e

### Lists

Lists are also a recursive typpe:


type 'a list = 
	| Nil
	| Cons of 'a * 'a list;;


In OCaml, [] is a notation for Nil and x::l a notation for Cons (x,l). The length of a list can be computed as:

$let rec length l = 
	match l with
	| x::l -> 1 + length l
	| [] -> 0;;


### Custom recursive types

WE can define custom recursive types

$ type ilist =
	| Nil
	| Cons of int * ilist;;

A typical value is 

> Nil

> Cons(3,Nil)

> Cons(5,Cons(3,Nil))

> ...


=> custom parametrized recurisive types

$ type 'a list = 
	| []
	| 'a :: 'a list;;

=> functions on recursive types are typically defined by recurrence:

let rec concat l m = 
	match l with
	| Nil -> m
	| Cons(x,l') -> Cons (x, concat l' m);;



























