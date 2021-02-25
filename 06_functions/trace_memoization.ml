(*trace*)

let rec fact n =
  if n = 1 then n else fact(n-1)*n
;;

fact 5;;

#trace fact;;

fact 5;;

#untrace fact;;


(*memorization*)


(*Navie Fibonacci:not using memorization*)
let c1 = ref 1;;
let rec fibonacci x =
  incr c1;
  match x with
    0 -> 1
  | 1 -> 1
  | _ -> fibonacci(x-1) + fibonacci(x-2)
;;

fibonacci 30;;
c1:= 0;;
fibonacci 30;;
!c1;;

(*we can see it recalculate the same value for many times*)


(*Fibonacci with memoization*)
let memo = Hashtbl.create 1;; (*create a hash table with size 1*)
(*so we have a hash table and it is polymorphic*)
memo;;
Hashtbl.clear memo;;
memo;;
let c2 = ref 0;;
let rec memo_fib n =
  incr c2;
  match n with
    0 -> 0
  | 1 -> 1
  | _ ->
     if Hashtbl.mem memo n then
       Hashtbl.find memo n
     else
       begin
         Hashtbl.add memo n(memo_fib(n-1) + memo_fib(n-2));
         Hashtbl.find memo n
       end
;;

memo_fib 30;;

!c2;;
