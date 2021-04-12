(*expression of types*)

let i = 10;;

let x = 13.2;;

let s = "string test";;

let c = 'g';;

let d = 22 and h = 3.4 and g = 'a' and e = "strstr";;

(*test: local definition*)
let x =
  let y = 2 in
  y * y;;

(*let () = print_int y;;*)

(*test: unit as the no return function*)
let str = "hello";;

let () = print_string ("the value of str is "^str);;

(*equality and inequality*)

let x = 9 and y = 9;;

x = y;;
x <> y;;
x == y;;
x != y;;

