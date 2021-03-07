(*Integer Identifiers*)

(*Suppose that a variable X exists and is an integer*)
(*Define a variable x_power_8 that uses three multiplications to calculate x to the power of 8. The only function your are allowed is the "*" operator*)
(*Hint: use auxiliary variables*)


let x = Random.int 9 + 1
;;(* not 0 *)

(*first test*)

let x_power_8 = x*x*x*x*x*x*x*x
;;

(*a better way*)
(*with less times of computations*)
let x_double = x*x
;;
let x_power_4 = x_double*x_double
;;
let x_power_8 = x_power_4 * x_power_4
;;
