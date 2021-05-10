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



