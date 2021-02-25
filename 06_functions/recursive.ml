let rec factorial n =
  if n==0 then 1 else
    n*factorial(n-1);;

factorial 5;;

let rec fibonacci_1 n =
  if n < 2 then 1 else fibonacci(n-1) + fibonacci(n-2);;

fibonacci_1 5;;

let rec fibonacci_2 x =
  match x with
    0 -> 1
  | 1 -> 1
  | n -> fibonacci_2(x-1) + fibonacci_2(x-2);;

fibonacci_2 5;;
fibonacci_2 12;;

let rec fibonacci_3 = function
    0 -> 1
  | 1 -> 1
  | n -> fibonacci_3 (n-1) + fibonacci_3 (n-2);;
                 
fibonacci_3 12;;

(*mutually recursive functions*)

let rec fun1 x =
  match x with
    0 -> "zero"
  | _ -> fun2 x
  and
    fun2 y = match y with
      1 -> "one"
    | _ -> fun1(y-1)
;;

fun1 7;;

fun2 8;;

fun1 0;;

(*there is a bug for*)
(*fun2 0;;*)



