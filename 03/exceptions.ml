#!/usr/bin/ocaml


exception My_exception;;

let f () = 
	raise My_exception;;

let rec fact n =
  if n = 0 then 1 else n * (fact (n-1));;

let test() = 
	try
		f ();
		print_endline "not raised";
	with
	| My_exception ->  print_endline "raised";;

test();;

let () = 
	assert (fact 5 = 120);;
