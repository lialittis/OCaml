(*example of expression of functions*)
let max x y = if x > y then x else y;;

max 5 6;;

max 6.7 8.9;;

max true false;;

max 'a' 'f';;

max "string1" "hello";;

(*take the output as a function*)
(*max x is the function name and y is the parameter*)


(*Annoymous Functions in OCAML*)

(*define the function*)
fun x y -> if x > y then x else y;;

(*add the two parameters*)
(fun x y -> if x > y then x else y) 4 5;;

let max = fun x y -> if x > y then x else y;;
max 4 5;;


(*addition*)

5 + 8;;
5.0 +. 8.0;;

(*Polymorphic functions in OCAML*)

let min x y = if x < y then x else y;;

min 5 6;;
min 'a' 'f';;
min 2.3 6.3;;


(*Higher-order functions & Currying in OCAML*)

let my_function f x y = f x y;;

my_function (fun x y -> if x > y then x else y) 5 6;;

my_function max 8 9;;



(*currying*)
let multiply x y = x * y;;
multiply 2 6;;
(*better understand*)
(multiply 2) 6;;
(*using currying*)
let multiply2 = multiply 2;;
multiply2 6;;




