open Printf

let a = [1;2;3;4];;


(* How to print a list *)
print_endline "Part 1: How to print a list";;


(* First Method *)	
print_endline "method 1 : self constructed function";;
let rec print_list = function
	|[]->()
	|e::l->print_int e; print_string " "; print_list l;;

print_list a;;

print_newline();;

print_endline "method 2 : open Printf";;

let ()=List.iter(printf "%d") a;;

print_newline();;

print_endline "-----------------------";;

print_endline "Part 2 : List.fold_left / List.fold_right";;

print_endline "SUM:"

let lst = [1;2;3;4];;

List.fold_left (+) 1 lst;;

print_list lst;;


print_endline "AVERAGE:";;

(*
let averate lst = 
	let (sum,n) = 
		List.fold_left(fun(sum,n) x -> (sum +. x,n +1 )) (0.0,0) lst
	in
	sum /.(float_of_int n)
*)

(*
let square x = x * x in
	List.map square [1;2;3;4];;

print
*)
