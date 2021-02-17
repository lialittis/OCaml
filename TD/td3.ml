(** Pure lambda-calculus. *)

type var = string;;

type t =
  | Var of var
  | App of t*t
  | Abs of var*t;;

let rec to_string = function
  | Var x -> x
  | App (t, u) -> Printf.sprintf "%s %s" (to_string t) (to_string u)
  | Abs (x, t) -> Printf.sprintf "lambda%s.%s" x (to_string t);;

let () =
  print_endline (to_string (Abs ("x", App (Var "y", Var "x"))));
  print_endline (to_string (App (Abs ("x", Var "y"), Var "x")));;

(** Is a free variable present? *)
let rec has_fv x = function
  | Var y -> y = x
  | App (t, u) -> has_fv x t || has_fv x u
  | Abs (y, t) -> x <> y && has_fv x t;;


let () =
  let t = App (Var "x", Abs ("y", App (Var "y", Var "z"))) in
  assert (has_fv "x" t);
  assert (not (has_fv "y" t));
  assert (has_fv "z" t);
  assert (not (has_fv "w" t))

(** Fresh variable name. *)
let fresh =
  let n = ref 0 in
  fun () : var ->
  incr n;
  "!" ^ string_of_int !n

(** Subtitute x for t in a term. *)
let rec sub x t = function
  | Var y -> if x = y then t else Var y
  | App (u, v) -> App (sub x t u, sub x t v)
  | Abs (y, u) ->
     if x = y then Abs (y, u)
     else if not (has_fv y t) then Abs (y, sub x t u)
     else
       let y' = fresh () in
       sub x t (Abs (y', sub y (Var y') u))

let subs = sub

let () =
  let t = App (Var "x", Abs ("y", Var "x")) in
  let i = Abs ("x", Var "x") in
  let ti = App (Abs ("x", Var "x"), Abs ("y", Abs ("x", Var "x"))) in
  assert (sub "x" i t = ti);
  assert (not (sub "x" (Var "y") (Abs ("y", Var "x")) = Abs("y", Var "y")))

(** Perform a reduction step. *)
let rec red = function
  | Var _ -> None
  | App (Abs (x, t), u) ->
     Some (sub x u t)
  | App (t, u) ->
     (
       match red t with
       | Some t' -> Some (App (t', u))
       | None ->
          match red u with
          | Some u' -> Some (App (t, u'))
          | None -> None
     )
  | Abs (x, t) ->
     (
       match red t with
       | Some t' -> Some (Abs (x, t'))
       | None -> None
     )

(** Print reduction steps. *)
let reduction t =
  print_endline ("   " ^ to_string t);
  let rt = ref (red t) in
  let steps = ref 0 in
  let loop = ref true in
  while !loop do
    match !rt with
    | Some t ->
       Printf.printf "-> %s\n%!" (to_string t);
       rt := red t;
       incr steps
    | None ->
       Printf.printf "%d reduction steps\n%!" !steps;
       loop := false
  done

let () =
  let id = Abs ("x", Var "x") in
  let id2 = App (id, id) in
  reduction (App (id2, id2))                    

    
