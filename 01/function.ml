#!/usr/bin/ocaml

let f x = 2 * x;;
let () =
	print_endline ("Define basic function f(x) = 2x");
	let a = f 2 in
	print_endline ("e.g. 2*2 = " ^ string_of_int(a));;


print_newline();;

let f2 b x y = 
	if b then x else y;;

let () =
	print_endline ("With multiple arguments");
	let a = f2 (1>2) 1 2 in
	print_endline ("e.g. a = f2 (1>2) 1 2, then a =  " ^ string_of_int(a));
	let a = f2 (1<2) 1 2 in
	print_endline ("e.g. a = f2 (1<2) 1 2, then a =  " ^ string_of_int(a));;

print_newline();;


let f3 () =
	print_endline ("Time since the beginning of execution: " ^ string_of_float(Sys.time()) ^ " seonds");;

f3 ();;

print_newline();;


let rec fact n = 
	if n = 0 then 1 else n *(fact(n-1));;

let () =
	print_endline("Recurive function");
	let a = 10 in
		print_endline ("The value of fact 10 is :" ^ string_of_int(fact a));;

let rec even n = 
	if n = 0 then true
	else odd(n-1);

and odd n = 
	if n = 0 then false
	else even(n-1);;

let () = 
	print_endline ("Matually recursive:");
	print_endline ("11 is even :" ^ string_of_bool(even 11));
	print_endline ("1 is odd :" ^ string_of_bool(odd 1));;


print_newline();;


let () = 
	print_endline ("pattern matching");;

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
print_newline();;

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

let() = print_newline();;
