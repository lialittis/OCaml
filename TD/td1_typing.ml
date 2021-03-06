let () =
  print_endline ("Getting Started!");;

let () =
  print_endline ("Definition of the programming language");;

type prog =
  | Bool of bool
  | Int  of int
  | Add  of prog * prog
  | Lt   of prog * prog
  | If   of prog * prog * prog;;

let rec string_of_prog = function
  | Bool b -> string_of_bool b
  | Int n -> string_of_int n
  | Add (p,q) -> "(" ^ string_of_prog p ^ " + " ^ string_of_prog q ^")"
  | Lt (p,q) -> "(" ^ string_of_prog p ^ " < " ^ string_of_prog q ^ ")"
  | If (p,q,r) -> "(if" ^ string_of_prog p ^ " then " ^ string_of_prog q ^ "else " ^ string_of_prog r ^ ")";;


let() =
  print_endline ("Reduction of programs");;


(*Reduction*)

let rec reduce = function
  | Bool _ | Int _ -> None
  | Add (Int n1, Int n2) -> Some (Int (n1 + n2))
  | Add (p1,p2) ->
     (
       match reduce p1 with
       | Some p1' -> Some (Add(p1',p2))
       | None ->
          match reduce p2 with
          | Some p2' -> Some(Add(p1, p2'))
          | None -> None
     )
  | Lt (Int n1, Int n2) -> Some (Bool (n1<n2))
  | Lt (p1,p2) ->
     (
       match reduce p1 with
       | Some p1' -> Some (Lt (p1',p2))
       | None ->
          match reduce p2 with
          | Some p2' -> Some(Lt(p1,p2'))
          | None -> None
     )
  | If (Bool true, p1, _) -> Some p1
  | If (Bool false, _, p2) -> Some p2
  | If (p,p1,p2) ->
     match reduce p with
     | Some p' -> Some (If(p',p1,p2))
     | None -> None;;

(*Normalization*)

let rec normalize p =
  match reduce p with
  | Some p -> normalize p
  | None -> p;;

(*test*)

let x = normalize (If(Lt(Add(Int 1,Add(Int 2,Int 3)),Int 4),Bool false,Int 5));;

let rec preduce = function
  | Bool _ | Int _ as p -> p
  | Add (Int n1, Int n2) -> Int (n1 + n2)
  | Add (p1, p2) -> Add (preduce p1, preduce p2)
  | Lt (Int n1, Int n2) -> Bool (n1 < n2)
  | Lt (p1,p2) -> Lt (preduce p1, preduce p2)
  | If (Bool b, p1, p2) -> if b then p1 else p2
  | If (p, p1, p2) -> If (preduce p, p1, p2);;

(*Type inference*)

type typ = TInt | TBool;;

let string_of_typ = function
  | TInt -> "int"
  | TBool -> "bool";;


(*test*)

let () =
  print_endline ("The type of TInt is " ^ string_of_typ TInt);;

exception Type_error;;

let rec infer = function
  | Bool _ -> TBool
  | Int _ -> TInt
  | Add (p1,p2) ->
     check p1 TInt;
     check p2 TInt;
     TInt
  | Lt (p1, p2) ->
     let t = infer p1 in
     check p2 t;
     TBool
  | If (p, p1, p2) ->
     check p TBool;
     let t = infer p1 in
     check p2 t;
     t
and check p t =
  if infer p <> t then raise Type_error;;

(*test*)

let test () =
  try
    infer(If(Lt(Add(Int 1,Int 2),Int 3),Int 4, Int 5));
    print_endline "Not Raised"
  with
  | Type_error -> print_endline "Raised type error";;

test();;


let typable p =
  try
    let _ = infer p in
    true
  with
  | Not_found -> false;;

typable (If(Lt(Add(Int 1,Int 2),Int 3),Int 4, Int 5));;

typable (Add(Int 1,Bool false));;

typable (If(Bool true, Int 1, Bool false));;
