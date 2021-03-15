#!/usr/bin/ocaml

(*First error*)

List.fold_left (fun a b -> (a,b)) 1 [1;2;3;4]
;;

(**
 Error: This expression has type 'a * 'b
       but an expression was expected of type 'a
       The type variable 'a occurs inside 'a * 'b 
 *)

(**This would create a tuple of an arbitrarily high arity (the size of the list), while OCaml tuples should have a constant size.
 *)
