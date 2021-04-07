(*(**) is used for comment*)

(*[...] generate a list, which is seperated by ; *)
let words = ["foo"; "bar" ; "baz"];;

(*, is used to generate a tuple, but the type of tuple is seperated by * *)
type name = string*string

(*gengerate a tuple*)

let johndoe = ("Jonn","Doe")

(*match mode*)
let foo s =
  match s with
  | (first, last) -> Printf.printf "my name is %s %s" first last

let r = foo johndoe

(* && is logical AND operation*)

(* || is logical OR operation*)

(* :: is appended by the list *)

let a = [1;2;3;4]

let b = 1::a

let a = 1::2::3::[]

(** ' is used for signal, x' and f' can be used as variables and functions
    while, 'a cannot be used as variables*)

(*| is used to write multiple types and matching modes*)

type foobar =
    Foo
  | Bar
  | Baz

let t v =
  match v with
  | Foo -> 1
  | Bar -> 2
  | Baz -> 3

(* -> *)


(* () is used for unit *)



(* ^ concat strings *)

let name = "hello "^"lanqy"

(*+. -. +. /.*)

(*_*)


(*[|...|] is used for array*)

let a = [|1;2;3|]

(* := <- pointer and assignment*)

let y = ref None;;

y;;

y := Some 3;;

y;;

(*= <> == !=*)


(*~ is used for the labelled parameter*)


(*? is used for optional parameter, can be ignored*)

let foo ?(z=0) x y = x + y > z;;

foo 3 3 ~z:2;;

foo 3 3 ~z:10;;

foo 2 1;;

(*` complex*)


(* @@ & |> *)


(* @ concat the list *)

let a = [2;3] @ [4;5;6]

