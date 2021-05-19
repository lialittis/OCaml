(* To build one function with type `unit -> 'a`*)

(* Wrong answer 1 *)

type 'a cell = {elt : 'a ; mutable next : 'a cell }
type 'a t = ('a option) ref
let create () =
  ref None
let pop q =
  match !q with
  | None -> invalid_arg "pop"
  | Some last when last.next == last ->
      q := None;
      last.elt
  | _ -> failwith "fail"
let foo () = pop (create ())

(* foo is in type `unit -> 'a` , but this code is equivalent
 * to  let foo () = invalid_arg "pop", we don't want exception
 * to participate *)

(* Wrong answer 2 *)

type 'a t = | Array : 'a array -> 'a t
            | Bytes : bytes -> char t
let foo (type a) (t:a t) =
  match t with
  | Array a -> Array.get a 0
  | Bytes s -> Bytes.get s 0

(* there is one function in type `'a t -> 'a` , but it is not completed *)

(* Answer :
 * It's not possible to write a function with type unit -> 'a without
 * resorting to ugly tricks, such as exceptions or unbounded recursion.
 * If you had such a function, you could call it to create values of any
 * type(s). In OCaml, values must be well-formed, we can't just return
 * NULL so the function would have to know how to construct arbitrary
 * data, however complicated.
 * So, it's not possible to write such a function in OCaml. *)
