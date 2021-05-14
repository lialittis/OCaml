(*#!/usr/bin/ocaml*)

(*Start with some examples*)

print_endline "Custom recursive types:"

type ilist =
| Nil
| Cons of int * ilist

type 'a mylist =
| []
| Cons of 'a * 'a  list

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

let string_of_date =

let earliest : date list -> date option =

let higher_order_helper = (** for earliest and max_hp*) 

(*-----------Advanced Part--------------*)


(*
module Type =
struct
  type record_type = {
  name : string;
  value : int;
}
end

open Type

*)
