# Labels and Polymorphic Variants


## Labelled and optional arguments to functions

Compared with python, OCaml also has a way to label arguments and have optional arguments with default values.

We give a basic syntax:

```ocaml
let rec range ~first:a ~last:b = 
	if a > b then []
	else a :: range ~first:(a+1) ~last:b;;
```

Notice that you cannot use the reserved words in OCaml. For example, `~from/~to` or `~start/~end` cannot be used.

The type of the previous `range` function was:

```
range : int -> int -> int list
```

And the type of our new `range` function with labelled arguments is:

```
range : first:int -> last:int -> int list
```

Confusingly, the ~(tilde) is not shown in the type definition, but you need to use it everywhere else.

Interestingly, with the labelled arguments, it doesn't matter which order you give the arguments anymore.

**An interestring example:**

```
let may ~f x = 
	match x with
	| None -> ()
	| Some -> ignore (f x);;
```

Need to know:
- the parameter ~f is just shorthand for ~f:f
- the second parameter x is unlabelled
- the type of the labelled f is a function of some sort
- the type of the unlabelled x is an 'a option
- the type of the `may` function is `may : f:('a -> 'b) -> 'a option -> unit`, notice in each case of the match the result is ()

## Optional arguments

We use `?` instead of `~` in front of the arguments for the optional arguments.


[TOCONTINUE]

# Thanks

https://ocaml.org/learn/tutorials/labels.html#More-shorthand

