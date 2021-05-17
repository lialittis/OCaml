(*#!/usr/bin/ocaml*)

(*Start with some examples*)

print_endline "Custom recursive types:"

type ilist =
| Nil
| Cons of int * ilist

type 'a mylist =
| []
| Cons of 'a * 'a mylist

(*Couples et multiplets*)
let c = (1, "asd")

let mc = (false, 1, "asd")

let () =
  let first = fst c in
  print_int first

let () =
  let second = snd c in
  print_string second

(*split*)

(*combine*)

(*map_combine*)

(*do_list_combine*)

(*-------------User-defined Data Type----------------*)

(* How to solve this problem :
 * sometimes the return is a value of type `t`, but sometimes it's not *)
let rec list_max (l: int list) =
  match l with
  | [] -> min_int
  | head::tail -> max head (list_max tail) 
  (** There will be an error of No :: constructor for type list if I keep the 
    * definition of 'a list above*)

let rec list_max (l: int list) =
  match l with
  | [] -> failwith "empty"
  | head::tail -> max head (list_max tail)


(* options *)

let extract o =
  match o with
  | Some i -> string_of_int i
  | None -> ""

let out_string = extract (Some 42)

(* Values of 't option may contain a value of type t, or they might contain nothing *)
let safe_hd (l:'a list) =
  match l with
  | [] -> None
  | hd::_ -> Some hd

let safe_tl (l:'a list) = (** if I didn't point out the type of l, it will be 'a mylist*)
  match l with
  | [] -> None
  | _::tl -> Some tl

(* A GOOD REC FUNCTION*)
let rec (list_max: 'a list -> 'a option) = function
| [] -> None
| h::t -> begin
    match list_max t with
    | None -> Some h
    | Some m -> Some (max h m)
  end


(*----------------Practice------------------*)

(*1. pokemon*)
type poketype = Normal | Fire | Water

type pokemon = {
  name: string ;
  hp : int ;
  ptype : poketype ;
}

let charizard = {name = "charizard" ; hp = 78 ; ptype = Fire}

let metapod = {name = "metapod" ; hp = 50 ; ptype = Normal}

let rec max_hp : pokemon list -> pokemon option = function
| [] -> None
| h::t -> begin
    match max_hp t with
    | None -> Some h
    | Some m -> if h.hp > m.hp then Some h else Some m
end

(*2. dates*)
type date = int * int * int (** year, month , day*)

let is_leap_year year =
  if year > 0 && (year mod 4 = 0) then
    if year mod 100 = 0 && year mod 400 <> 0 then false
    else true
  else false

let check_date d =
  let (year, month, day) = d in
  if (year < 0) || (month <0) || month > 12 then false
  else begin
    match month with
    | 1 | 3 | 5 | 7 | 8 | 10 | 12 -> if day < 0 || day > 31 then false else true
    | 2 -> begin
        match is_leap_year year with
        | true -> if day > 0 && day < 29 then true else false
        | false -> if day > 0 && day < 28 then true else false
      end
    | _ -> if day > 0 && day > 30 then true else false
  end

let test_true =
  check_date (2021,5,14)

let test_wrong =
  check_date (2021,5,32)

let is_before date1 date2 =
  if check_date date1 && check_date date2 then
    let (y1,m1,d1) = date1 and (y2,m2,d2) = date2 in
    begin
      if y1 < y2 then true
      else if y1 > y2 then false
      else if m1 < m2 then true
      else if m1 > m2 then false
      else if d1 < d2 then true
      else false
    end
  else failwith "wrong date"

let test_is_before = is_before (2021,5,14) (2021,5,15)

let string_of_date date =
  match check_date date with
  | true -> begin
      let (y,m,d) = date in
      let month_str =
        match m with
        | 1 -> "January"
        | 2 -> "February"
        | 3 -> "March"
        | 4 -> "April"
        | 5 -> "May"
        | 6 -> "June"
        | 7 -> "July"
        | 8 -> "August"
        | 9 -> "September"
        | 10 -> "October"
        | 11 -> "November"
        | 12 -> "December"
        | _ -> failwith "impossible!"
      in
      month_str ^ " " ^ string_of_int d ^ ", " ^ string_of_int y
    end
  | false -> failwith "wrong date type"

(* suppose that the input are always in correct type *)
let rec earliest : date list -> date option = function
| [] -> None
| hd::tl -> begin
    match earliest tl with
    | None -> Some hd
    | Some x -> if is_before hd x then Some hd else Some x
  end

let test_earliest = earliest [(2001,1,5) ; (2021,1,1) ; (2001,1,1)]


(* A GOOD EXAMPLE OF CONSTRUCTION FOR HIGHER ORDER HELPER FUNCTION*)
let rec higher_order_helper (f:'a -> 'a -> bool) (list:'a list) : 'a option =
  match list with
  | [] -> None
  | hd::tl -> begin
      match higher_order_helper f tl with
      | None -> Some hd
      | Some x -> if f hd x then Some hd else Some x
    end

(*3. Currying *)

(* curried function : t1 -> t2 -> t3
 * uncurried function : (t1 * t2) -> t3 *)

let uncurried_list_nth pair =
  let (t1,t2) = pair in
  List.nth t1 t2

let uncurried_list_append pair =
  let (t1,t2) = pair in
  List.nth t1 t2

let uncurried_char_compare pair =
  let (t1,t2) = pair in
  Char.compare t1 t2

open Stdlib
(*
let uncurried_pervasives_max pair =
  let (t1,t2) = pair in
  Pervasives.max t1 t2
*)

(* define a uncurry function to uncurry any functions like above *)
let uncurry curried_f pair =
  let (t1,t2) = pair in
  curried_f t1 t2

let curry uncurried_f t1 t2 =
  let pair = (t1,t2) in
  uncurried_f pair

(* 4. Roman Numbers *)

type rnumberal = I | V | X | L | C | D | M

type rnumber = rnumberal list

(* conver a single Roman number to an integer *)
let int_of_rnumberal = function
| I -> 1
| V -> 5
| X -> 10
| L -> 50
| C -> 100
| D -> 500
| M -> 1000

(* not used acutally *)
let couplable_rnumberal t1 t2 =
  match t1 with
  | I -> begin
      match t2 with
      | I | V | X -> true
      | _ -> false
    end
  | V -> begin
      match t2 with
      | I -> true
      | _ -> false
    end
  | X -> begin
      match t2 with
      | X | L | C -> true
      | _ -> false
    end
  | L -> begin
      match t2 with
      | X -> true
      | _ -> false
    end
  | C -> begin
      match t2 with
      | C | D | M -> true
      | _ -> false
    end
  | D -> begin
      match t2 with
      | C -> true
      | _ -> false
    end
  | M -> begin
      match t2 with
      | M -> true
      | _ -> false
    end

let rec int_of_rnumber: rnumber -> int = function
| [] -> 0
| hd::tl -> begin
    match tl with
    | [] -> int_of_rnumberal hd
    | _ -> begin
        let inth = int_of_rnumberal hd in
        let intt = int_of_rnumber tl in
        let right_order = int_of_rnumberal (List.nth tl 0) in
        let left_order = inth in
        if left_order >= right_order then
          inth + intt
        else intt - inth
      end
  end

let test_ior = int_of_rnumber [M;M;C;M;X;C;I;X]

(* Bug : offer one wrong Roman number, this function cannot recognize it *)
let test_bug_wrong_rn = int_of_rnumber [M;M;C;M;X;C;X;X;X;I;X]



(*-----------Advanced Part--------------*)


(*module Type =
struct
  type record_type = {
  name : string;
  value : int;
}
end *)

(* 1. For the dates problem *)

(* It is not possible to say something like :
 * type date = { year : int | year > 0 } * { month : int | month in [1..12] } * { day : int | day in [1..31] } *)

(* INTRODUCE abstract type *)

module Year : sig
  type t
  val make : int -> t
  exception InvalidYear of int
end = struct
  type t = int
  exception InvalidYear of int
  let make x = if x < 0 then raise (InvalidYear x) else x
end

(* a general approach*)
module MakeIntSubset (P: sig val predicate : int -> bool end) : sig
  type t
  val make : int -> t
  exception InvalidInt of int
end = struct
  type t = int
  exception InvalidInt of int
  let make x = if P.predicate x then raise (InvalidInt x) else x
end

module Year = MakeIntSubset (struct let predicate x = x > 0 end)

module Month = MakeIntSubset (struct let predicate x = x >= 1 && x <= 12 end)

module Day = MakeIntSubset (struct let predicate x = x >= 1 && x <= 31 end)

(* For more precise control of Day, we need to create one more module like Day_safe 
 * with the same approach, we don't have to implement it here *)


