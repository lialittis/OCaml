(*#!/usr/bin/ocaml*)

print_endline "Custom recursive types:"
;;

type ilist = 
| Nil
| Cons of int * ilist
;;

type 'a list = 
| []
| Cons of 'a * 'a  list
;;


(*Couples et multiplets*)

let c = (1, "asd")

let mc = (false, 1, "asd")

let first = fst c in
print_int first

let second = snd c in
print_string second

(*split*)

(*combine*)

(*map_combine*)

(*do_list_combine*)

