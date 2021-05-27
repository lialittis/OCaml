open Stdlib

(* 1. last : 'a list -> 'a option *)
let rec last : 'a list -> 'a option = function
| [] -> None
| hd::tl -> (
    match tl with
    | [] -> Some hd
    | _ -> last tl
  )

(* 2. Find the last but one elements of a list *)
let rec last_two : 'a list -> ('a*'a) option = function
| [] -> None
| hd::tl -> begin
    match tl with
    | [] -> None
    | [x] -> Some (hd , x)
    | _ -> last_two tl
  end

(* 3. Find the K'th element of a list *)
let rec at (n:int) = function
| [] -> None
| hd::tl -> if n = 1 then Some hd else (at (n-1) tl)


(*4. Find the number of elements of a list *)
let rec length = function
| [] -> 0
| hd::tl -> begin
    match tl with
    | [] -> 1
    | _ -> (length tl) + 1
end

(* tail-recurive method: using a constant amount of stack memory regardless of list size *)
let length list =
  let rec aux n = function
  | [] -> n
  | _::t -> aux (n+1) t
  in aux 0 list

(* 5. Reverse a list *)
let rev list =
  let rec aux acc = function
  | [] -> acc
  | h::t -> aux (h::acc) t in
  aux [] list

(* 6. Find out whether a list is a palindrome, where a palindrome is its own reverse. *)
let is_palidrome list =
  let list' = rev list in
  if list' = list then true
  else false

(* simpler approach *)
let is_palidrome list=
  list = List.rev list

(* 7. Flatten a nested list structure *)

(* there is no nested list in OCaml, so we define one first *)
type 'a node =
  | One of 'a
  | Many of 'a node list

let flatten (nlist: 'a node list) =
  let rec aux (acc:'a list) = function
  | [] -> acc
  | One x :: t ->  aux (x::acc) t
  | Many l :: t -> aux ( aux acc l) t in
  List.rev (aux [] nlist)

(* 8. Eliminate consecutive duplicates of list elements *)
let rec compress alist =
  match alist with
  | a :: (b :: _ as t ) -> if a = b then compress t else a :: compress t
  | smaller -> smaller

(* 9. Pack consecutive duplicates of list elements into sublists *)
let pack alist =
  let rec aux current acc = function
  | [] -> []
  | [x] -> (x :: current) :: acc
  | a :: (b :: _ as t) ->
      if a = b then aux (a::current) acc t
      else aux [] ((a :: current) :: acc) t in
  List.rev (aux [] [] alist)

(* 10. Run-length encoding of a list *)
let encode alist =
  let rec aux num acc = function
  | [] -> []
  | [x] -> (num+1,x)::acc
  | a :: (b::_ as t) ->
      if a = b then aux (num+1) acc t
      else aux 0 ((num+1,a)::acc) t
  in
  List.rev (aux 0 [] alist)

(* another approach is using pack function declard above, which requires more memory *)

(* 11. Modified run-length encoding *)
type 'a rle =
  | One of 'a
  | Many of int * 'a

let encode alist =
  let create_element num elem =
    if num = 1 then One elem
    else Many (num,elem)
  in
  let rec aux num acc = function
  | [] -> []
  | [x] ->(create_element (num+1) x)::acc
  | a::(b::_ as t ) ->
      if a = b then aux (num+1) acc t
      else aux 0 ((create_element (num+1) a)::acc) t
  in
  List.rev(aux 0 [] alist)

(*example*)
;;
let result = encode ["e";"e";"z";"z";"z";"e";"&";"&"];;

(* 12. Decode a run-length encoded list. *)


(*example*)
;;
let result = decode [Many (4, "a"); One "b"; Many (2, "c"); Many (2, "a"); One "d"; Many (4, "e")];;
