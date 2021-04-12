#!/usr/bin/ocaml

let () = 
	print_endline "Custom recursive types:";;

type ilist = 
	| Nil
	| Cons of int * ilist;;

type 'a list = 
	| []
	| 'a :: 'a list;;
