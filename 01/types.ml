let () = 
	print_endline "Custom recursive types:";;

type ilist = 
	| Nil
	| Cons of int * ilist;;

let 

