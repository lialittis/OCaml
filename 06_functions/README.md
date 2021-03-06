# Functions

## Formes

let <name> <parameter> = <expression>;;

e.g.

let max x y = if x > y then else y;;

Notice that: here is that we didn't actually specify the types of the input variables and the output variable. That is good, because it means that we can provide two integers or two floats or two cahracters or even two strings.

> val max : 'a -> 'a -> 'a = <fun>

'a means that the function is polymorphic: it can have/receive a variable of any type.(But, in the last example, the two variables have to have the same type)

This is another nice way to declare anonymous function by using function expressions. 

* Note that: the name of function should named by minuscule letters.

## Go deeper

If we go down to the very bottom of how functions work in ocaml, we can find out that actually every function receives only one variable and returns one variable. 

**We can actually pass them as parameters to other functions instead of passing a variable here of tyype float\char\string or normal type, we can actually pass a function. Another thing is that we can actually return a function instead of a primitive type or mayby a struct or a class or an instance of a class. Not only this, we can store output functions as data structures.**

e.g. we can take max x as function name and y as the parameter.

## Annonymous Functions

 # fun x y -> if x > y then x else y;;
 - : 'a -> 'a -> 'a = <fun>

 # (fun x y -> if x > y then x else y) 4 5;;
 - : int = 5

we can also set a name for the function. 

### Addition, subtraction, multiplication or division

For integers: + - * /

For floats: +. -. * .  /.


## Polymorphic Functions

 # let min x y = if x < y then x else y;;
 val min : 'a -> 'a -> 'a = <fun>
 # min 5 6;;
 - : int = 5
 # min 'a' 'f';;
 - : char = 'a'
 # min 2.3 6.3;;
 - : float = 2.3

## Higher-order functions & Currying in OCAML

Higer-order functions in OCaml are the functions which actually take another function as a parameter or maybe a function containing structure sort of as an argument as a parameter. So in other words, a higher-order function is a function that receives as one or more of its parameters actually a function or functions or maybe produces a function as its output.

e.g. 

let my_function f x y = f x y;;

my_function (fun x y -> if x > y then x else y) 5 6;;



Currying is a technique of transforming a function that takes multiple arguments to a chain of other functions, each of these new functions takes only one argument.

e.g.

(*currying*)
let multiply x y = x * y;;
multiply 2 6;;
(*better understand*)
(multiply 2) 6;;
(*using currying*)
let multiply2 = multiply 2;;
multiply2 6;;

## Recursive Functions

An example of Factorial: 

1. Iterative implementation

int Factorial(int n)
{
	int fact = 1;
	for(int count = 2; count < n; count ++)
		fact = fact * count;
	return fact;
}

2. Recursive implementation

int Factorial(int n)
{
	if (n==0) // base case
		return 1;
	else
		return n*Factorial(n-1);
}

Another example: Fibonacci

Watch the recursive.ml file, there are several different ways to build a rec function, with or without key word `function`.



### Definition

* Recursive functions must include the keyword `rec`
* (* of factorial function*)
	let rec fact n = 
		if n == 1 then 1 else n * fact(n-1);;


### Addition

Mutually recursive functions must be defined simultaneously.

There is one example in the recursive.ml file.


## Tracing Functions

We use hash trace and give the function name and then the function will be traced. It helps us to trace the parameters and the computations or the results of a functions.

### how to use

 # trace <function>

 # untrace <function>


### Example

`
 # let rec fact n =
   if n = 1 then n else fact(n-1)*n
 ;;

 fact 5;;

 #trace fact;;

 fact 5;;
     val fact : int -> int = <fun>
 #   - : int = 120
 #   fact is now traced.
 #   fact <-- 5
 fact <-- 4
 fact <-- 3
 fact <-- 2
 fact <-- 1
 fact --> 1
 fact --> 2
 fact --> 6
 fact --> 24
 fact --> 120
 - : int = 120
`

## Memoization

Build a hash table:

`
 # let memo = Hashtbl.create 1;;
 val memo : ('_a, '_b) Hashtbl.t = <abstr>
`
`
 # Hashtbl.clear memo;;
`

Watch the example in the trace\_memoization.ml.





