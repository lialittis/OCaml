(*test: local definition*)
let x =
	let y = 2 in
		y * y;;

(*let () = print_int y;;*)

(*test: unit as the no return function*)
let str = "hello";;

let () = print_string ("the value of str is "^str);;
