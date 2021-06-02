(* First approach for reporting errors *)
(* Run in utop *)
(*-----------------------------Error-Aware Return Types--------------------------------*)

(* The best way in OCaml to signal an error is to include that error in your
 * return value. *)

(* 1. Encoding errors with options *)
open Base

(*List.find*) 
(*'a list -> f:('a -> bool) -> 'a option = <fun>*)

(* The option in the return type indicates that the function may not succeed
 * in finding a suitable element *)
let result = List.find [1;2;3] ~f:(fun x -> x >= 2)

let result2 = List.find [1;2;3] ~f:(fun x -> x > 10)

(* The match statement is used to handle the error cases, propagating a None in
 * hd or last into the return value of compute_bounds.*)
let compute_bounds ~compare list =
  let sorted = List.sort ~compare list in
  match List.hd sorted, List.last sorted with
  | None,_ | _, None -> None
  | Some x, Some y -> Some (x,y)


(* in the find_mismatches that follows, errors encountered during the computation
 * do not propagate to the return value of the function.*)
let find_mismatches table1 table2 =
  Hashtbl.fold table1 ~init:[] ~f:(fun ~key ~data mismatches ->
    match Hashtbl.find table2 key with
    | Some data' when data' <> data -> key :: mismatches
    | _ -> mismatches
  )

(* 2. Encoding erros with result *)
(* useful to stqndardize on an error type *)

(* A Result.t is essentially an option augumented with the ability to store
 * other information in the error case. *)
module Result : sig
  type ('a,'b) t = | Ok of 'a
                   | Error of 'b
end = struct
    type ('a,'b) t = | Ok of 'a
                   | Error of 'b
end


(* examples *)
(*[ Ok 3; Error "abject failure"; Ok 4 ]*)
(*(int, string) result list = [Ok 3; Error "abject failure"; Ok 4]*)

(* 3.Error and Or_error *)
(* errors reporting : time-consuming => Errors gets around this issure through
 * laziness. *)

(* an Error.t allows you to put off generation of the error string until and
 * unless you need it, which means a lot of the time you never have to construct
 * it at all. You can of course construct an error directly from a string: *)

let x = Error.of_string "something went wrong"

let x = Error.of_thunk (fun () ->
Printf.sprintf "something went wrong: %f" 32.3343)

(* !!!??? In this case, we can benefit from the laziness of Error, since the thunk won’t be called unless the Error.t is converted to a string.*)

(* !!!??? S-expressions*)

let x = Error.create "Unexpected character" 'z' Char.sexp_of_t
(* Note that the character isn’t actually serialized into an s-expression until the error is printed out. *)
;;
#require "ppx_jane"

let custom_to_sexp = [%sexp_of: float * string list * int];;

custom_to_sexp (3.5, ["a";"b";"c"], 6034);;

(*We can use this same idiom for generating an error:*)
Error.create "Something went terribly wrong"
  (3.5, ["a";"b";"c"], 6034)
  [%sexp_of: float * string list * int]
;;

(* Error also supports operations for transforming errors *)
Error.tag
  (Error.of_list [ Error.of_string "Your tires were slashed";
                   Error.of_string "Your windshield was smashed" ])
  "over the weekend"
;;

(* TOLEARN : need more examples *)


(* 3. bind and Other Error Handling Idioms *)

(* definition of bind of options *)
let bind option f =
  match option with
  | None -> None
  | Some x -> f x
;;

(* examples *)
let compute_bounds ~compare list =
  let sorted = List.sort ~compare list in
  Option.bind (List.hd sorted) (fun first ->
    Option.bind (List.last sorted) (fun last ->
        Some (first,last)))
;;

(* infix operator form of bind *)
let compute_bounds ~compare list =
  let open Option.Monad_infix in
  let sorted = List.sort ~compare list in
  List.hd sorted >>= fun first ->
  List.last sorted >>= fun last ->
  Some (first,last)
;;

(* TODO : 4. MONADS AND Let_syntax *)

(* ------------------------------Exceptions-----------------------------*)

(* examples *)

let x = 3 / 0;;

List.map ~f:(fun x -> 100 / x) [1;3;0;4];;

(* If we put a printf in the middle of the computation, we can see that List.map
 * is interrupted partway through its execution, never getting to the end of the list: *)
List.map ~f:(fun x -> Stdio.printf "%d\n%!" x; 100 / x) [1;3;0;4];;

(* Define your own exception *)
exception Key_not_found of string;;

raise (Key_not_found "a");;

(* Exceptions are ordinary values and can be manipulated just like other OCaml values: *)
let exceptions = [ Division_by_zero; Key_not_found "b" ];;

List.filter exceptions  ~f:(function
  | Key_not_found _ -> true
  | _ -> false)
;;

let rec find_exn alist key = match alist with
  | [] -> raise (Key_not_found key)
  | (key',data) :: tl -> if String.(=) key key' then data else find_exn tl key
;;

let alist = [("a",1); ("b",2)];;

find_exn alist "a";;

find_exn alist "c";;

(* To know more about exceptions, to read exceptions.ml*)
