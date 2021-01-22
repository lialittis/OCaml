#!/usr/bin/ocaml

let foo = function
| "zero" -> 0
| "one" -> 1
| "two" -> 2
| "three" -> 3
| "four" -> 4
| "five" -> 5
| _ -> 6;;

let a = foo "five";;

let b = foo "one";;

print_string "b is ";;
print_int b;;

let add arg1 arg2 = arg1 + arg2;;

let add_five = add 5;;

let five_a = add_five a;;

let five_b = add_five b;;

let a_b = add a b;;

print_string "five_a is ";;
print_int five_a;;

print_string "five_b is ";;
print_int five_b;;

print_string "a_b is ";;
print_int a_b;;

print_newline;;
