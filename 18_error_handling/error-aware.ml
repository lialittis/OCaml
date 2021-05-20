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
