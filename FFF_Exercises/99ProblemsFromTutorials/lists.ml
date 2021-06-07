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

let decode encoded_list =
  let rec aux acc = function
  | [] -> acc
  | h::t -> begin
      match h with
      | One a -> aux (a::acc) t
      | Many (num,x) -> (
          let rec replicate acc n e =
            if n = 0 then acc
            else replicate (e::acc) (n-1) e
          in
          let l = replicate [] num x in
          aux (l@acc) t
        )
    end
  in
  List.rev (aux [] encoded_list)

(*example*)
let result = decode [Many (4, "a"); One "b"; Many (2, "c"); Many (2, "a"); One "d"; Many (4, "e")]

(* standard solution *)
let decode list =
    let rec many acc n x =
      if n = 0 then acc else many (x :: acc) (n - 1) x
    in
    let rec aux acc = function
      | [] -> acc
      | One x :: t -> aux (x :: acc) t
      | Many (n, x) :: t -> aux (many acc n x) t
    in
      aux [] (List.rev list)

(* 13. Run-length encoding of a list (direct solution) *)
let encode alist =
  let rle cnt a = if cnt = 1 then One a else Many (cnt,a) in
  let rec aux cnt acc = function
  | [] -> [] (* only be reached if original list is empty *)
  | [x] -> rle (cnt+1) x :: acc
  | h::(s::_ as t) -> (
      if h = s then aux (cnt + 1) acc t
      else aux 0 (rle (cnt+1) h :: acc ) t
    )
  in
  List.rev (aux 0 [] alist)


(* example *)
let result = encode ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"]

(* 14. Duplicate the elements of a list *)
let duplicate alist =
  let rec aux acc = function
  | [] -> acc
  | h::t -> aux (h::h::acc) t
  in
  List.rev (aux [] alist)

(* example *)
let result = duplicate ["a";"b";"c";"c";"d"]

(* 15. Replicate the elements of a list given number of times *)
let replicate (alist:'a list) (num:int) : 'a list =
  let rec rep (acc:'a list) (nu:int) (element:'a) =
    if nu = 0 then acc
    else rep (element::acc) (nu-1) element
  in
  let rec aux (ac:'a list) = function
  | [] -> ac
  | h::t -> aux (rep ac num h) t
  in
  List.rev (aux [] alist)


(* example *)
let result = replicate ["a";"b";"c"] 3

(* 16 Drop every N'th element from a list *)
let drop alist num =
  let rec aux count acc = function
  | [] -> acc
  | h::t ->
      if (count mod num <> 0) then aux (count+1) (h::acc) t
      else aux (count+1) acc t
  in
  List.rev (aux 1 [] alist)

(* example *)
let result = drop ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"] 3

(* standard solution: modify the original list directly *)
let drop list n =
    let rec aux i = function
      | [] -> []
      | h :: t -> if i = n then aux 1 t else h :: aux (i + 1) t  in
    aux 1 list

(* 18. split a list into two parts; the length of the first part is given *)
let split alist num =
  let rec aux i acc = function
  | [] -> List.rev acc,[]
  | h::t -> if i = 0 then List.rev (h::acc) , t else aux (i-1) (h::acc) t
  in
  aux num [] alist

(* example *)
let result = split ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"] 3

let result = split ["a"; "b"; "c"; "d"] 5

(* 19. Rotate a list N places to the left *) (*medium*)
let rec rotate alist num =
  if num > 0 then
    match alist with
    | [] -> []
    | h::t -> rotate (t@[h]) (num-1)
  else if num < 0 then
    match alist with
    | [] -> []
    | l ->
        match (List.rev l) with
        | h::t -> rotate (List.rev (t@[h])) (num+1)
        | [] -> []
  else alist


(* example *)
let result = rotate ["a"; "b"; "c"; "d"; "e"; "f"; "g"] 3

let result = rotate ["a"; "b"; "c"; "d"; "e"; "f"; "g"] (-2)

(* standard solution *)
let split list n =
  let rec aux i acc = function
  | [] -> List.rev acc, []
  | h :: t as l -> if i = 0 then List.rev acc, l
      else aux (i - 1) (h :: acc) t  in
  aux n [] list

let rotate list n =
  let len = List.length list in
    (* Compute a rotation value between 0 and len - 1 *)
  let n = if len = 0 then 0 else (n mod len + len) mod len in (* a good example of mod *)
  if n = 0 then list
  else let a, b = split list n in b @ a

(* 20. Remove the K'th element from a list *)
let remove_at num alist =
  let rec aux i = function
  | [] -> []
  | h::t -> if i = num then t else h::(aux (i+1) t)
  in
  aux 0 alist

(* example *)
let result = remove_at 1 ["a";"b";"c";"d"]

(* 21. Insert an element at a given position into a list *) (*easy*)
let insert_at el index alist =
  let rec aux i = function
  | [] -> [el] (* need to add the element *)
  | h::t -> if i = index then el::h::t else h::(aux (i+1) t)
  in
  aux 0 alist

(* example *)
let result = insert_at "alfa" 1 ["a";"b";"c";"d"]

let result = insert_at "alfa" 3 ["a"; "b"; "c"; "d"]

let result = insert_at "alfa" 4 ["a"; "b"; "c"; "d"]

(* 22. Create a list containing all integers within a given range *)
let range e1 e2 =
  let rec aux acc start =
    if start < e2 then aux (start::acc) (start+1)
    else if start > e2 then aux (start::acc) (start-1)
    else start::acc
  in
  List.rev (aux [] e1)

(* example *)
let result = range 4 9

let result = range 9 4

(* 23. Extract a given number of randomly selected elements from a list *)(*medium*)
(* The selected items shall be returned in a list. We use the Random module but do not initialize it with Random.self_init for reproducibility. *)
let rand_select alist num =
  let rec extract acc n = function
  | [] -> raise Not_found
  | h::t -> if n = 0 then (h,acc @ t) else extract (h::acc) (n-1) t
  in
  let extract_rand list len =
    extract [] (Random.int len) list
  in
  let rec aux n acc list len =
    if n = 0 then acc else
    let picked,rest = extract_rand list len in
    aux (n-1) (picked::acc) rest (len-1)
  in
  let len = List.length alist in
  aux (min num len) [] alist len

(* example *)
let result = rand_select ["a";"b";"c";"d";"e";"f";"g";"h"] 3
