(*simple functions*)

(*simple functions over integers*)

(**Let's define two functions working with integers:
1.multiple_of that takes two integer parameters, n and d, and determines whether n is a multiple of d. The function must return a boolean value. This function can be written without recursion. Look at the operators defined on integers in sequence 1.
2.integer_square_root that calculates the integer square root of a positive integer n, that is the largest integer r such that r * r <= n. Hint: you may use floating point arithmetic, but don't forget that you have to convert explicitely between float and int.*)


let multiple_of n d =
  if n mod d = 0 then true else false
;;

let integer_square_root n =
  let floatn = float_of_int n in
  let square_floatn = sqrt floatn in
  int_of_float square_floatn
;;

(*test*)

multiple_of 5 4
;;

integer_square_root 16
;;

(*simple functions over strings*)

(**Let's define two functions working with strings:

1.last_character that returns the last character of a string, assuming that the string argument is not empty;
2.string_of_bool that converts a boolean value to its string representation.*)

let last_character str =
  let l = String.length str in
  str.[l-1]
;;

let string_of_bool truth =
  match truth with
  | true -> "true"
  | false -> "false"
;;


last_character "read me"
;;


string_of_bool true
;;

