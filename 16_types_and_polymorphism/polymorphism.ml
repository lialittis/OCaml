(* 1. Variant types*)

(* To implement our own lists, and other more interesting data structures,
 * such as binary trees
 *)

type answer = Yes | No | Maybe

let x:answer = Yes

(* The variant type is declared with a set of constructors that describe the
 * possible ways to make a value of that type.*)

type eitherPoint = TwoD of float * float
                 | ThreeD of float * float * float


(* Way to extract eitherPoint
 * It can be done by pattern matching *)
let lastTwoComponents (p : eitherPoint) : float * float =
  match p with
    TwoD (x,y) -> (x,y)
  | ThreeD (x,y,z) -> (y,z)

(* 2. Variant type syntax 
 * We use X as metavariable to represent the name of a constructor,
 * and T to represent the name of a type*)

(* type T = X1 [of t1] | X2 [of t2] | ... | Xn [of tn] *)

(* variant types introduce new syntax for terms e, patterns p, and values v*)

(* e::= ...| X e | match e with p1 -> e1 | ... | pn -> en
 * p::= X | X (x1:t1,...,xn:tn)
 * v::= c | (v1,v2,...,vn) | fun p -> e | X v *)

(* Note that the vertical bars in the expression "match e with ..." are part
 * of the syntax of this construct, the others are part of the BNF notation *)

(* 3. Implementing integer lists *)

type intlist = Nil | Cons of (int * intlist) (*two constructor; recursive type*)

(* examples *)

let list1 = Nil (*the empty list; []*)
let list2 = Cons (1, Nil) (*[1]*)
let list3 = Cons (2, Cons (1,Nil)) (*[2;1]*)
let list4 = Cons (2,list2) (*[2;1]*)
let list5 = Cons (1, Cons (2, Cons (3, Cons (4, Cons (5 , Nil)))))

(* IMPORTANT: learn to use pattern matching*)

(* Returns the length of lst *)
let rec length (lst : intlist) : int =
  match lst with
  | Nil -> 0
  | Cons (h,t) -> length t + 1

(* is the list empty ?*)
let is_empty (lst : intlist) : bool = 
  match lst with
  | Nil -> true
  | Cons _ -> false


(* Returns the sum of the elements in the list *)
let rec sum (lst : intlist) : int =
  match lst with
  | Nil -> 0
  | Cons (h,t) -> h + sum t


(* string representation *)
let rec to_string (lst : intlist) : string =
  match lst with
  | Nil -> ""
  | Cons (i,Nil) -> string_of_int i
  | Cons (h,Cons (i,j)) -> string_of_int h ^ "," ^ to_string (Cons (i,j))

(* Returns the head of the list *)
let head (lst : intlist) : int = 
  match lst with
  | Nil -> failwith "empty list"
  | Cons (h,t) -> h

(* Return the nth element of the list*)
let rec nth (lst : intlist) (n : int) : int =
  match lst with
  | Nil -> failwith "empty list"
  | Cons (h,t) ->
      if n = 0 then h
      else nth t (n-1)

(* Append two lists *)
let rec append (lst1 : intlist) (lst2:intlist) : intlist =
  match lst1 with
  | Nil -> lst2
  | Cons (h,t) ->
      Cons (h, append t lst2)

(* Reserve the list *)
let rec reserve (lst : intlist) : intlist =
  match lst with
  | Nil -> Nil
  | Cons (h,t) -> append (reserve t) (Cons (h,Nil))


(*****************************************
 * Examples
 *****************************************)

(* Here is a way to perform a function to each element
 * of a list. *)

let inc (x : int) : int = x + 1
let square (x : int) : int = x * x

let rec append_to_all (lst:intlist) : intlist =
  match lst with
  | Nil -> Nil
  | Cons (h,t) -> Cons (inc h, append_to_all t)

let rec square_to_all (lst:intlist) : intlist =
  match lst with
  | Nil -> Nil
  | Cons (h,t) -> Cons (square h, square_to_all t)

let rec do_function_to_all (f:int->int) (lst:intlist) : intlist =
  match lst with
  | Nil -> Nil
  | Cons (h,t) -> Cons (f h,do_function_to_all f t)

let addone_to_all (lst:intlist) : intlist =
  do_function_to_all inc lst

let square_all (lst:intlist) : intlist =
  do_function_to_all square lst

(* Even Better : Use anonymous functions *)

let addone_to_all (lst:intlist) : intlist =
  do_function_to_all (fun x -> x + 1) lst

let square_all (lst:intlist) : intlist =
  do_function_to_all (fun x -> x * x) lst


(* Say we want to compute the sum and product of integers in a list *)

let rec sum (lst : intlist) : int =
  match lst with
  | Nil -> 0
  | Cons (h,t) -> h + sum t

let rec product (lst : intlist) : int =
  match lst with
  | Nil -> 0
  | Cons (h,t) -> h * product t

(* Better : a general function collapse that takes an operation and an identity
 * element for that operation *)

let rec collapse (f : int -> int -> int) (b:int) (lst:intlist) : int =
  match lst with
  | Nil -> b
  | Cons (h,t) -> f h (collapse f b t)

let sum (lst:intlist) : int =
  let add (i1 : int) (i2 : int) : int = i1 + i2 in
  collapse add 0 lst

let product (lst:intlist) : int =
  let mul (i1 : int) (i2 : int) : int = i1 * i2 in
  collapse mul 1 lst

(* we can also use anonymous function for the above functions*)



(* Trees of integers*)

type inttree = Empty | Node of node
and node = { value : int ; left : inttree ; right : inttree }

(* Return true if the tree contains x. *)

let rec search (t: inttree) (x:int) : bool =
  match t with
  | Empty -> false
  | Node {value = v ; left = l; right = r} ->
      v = x || search l x || search r x

let tree1 =
  Node {value = 2 ; left = Node { value = 1 ; left = Empty ; right = Empty };
        right = Node {value = 3; left = Empty ; right = Empty }}

let z = search tree1 3

(* Representing trees with a recursive type *)

(* To be continuing *)
