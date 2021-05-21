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

(* DECLARING EXCEPTIONS USING [@@deriving sexp] *)
(* TODO *)
