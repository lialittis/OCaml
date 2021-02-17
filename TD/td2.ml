(*SIMPLE METHOD*)

(*1.1 Formulas*)

type var = int;;

type formula =
  | Var of var
  | And of formula * formula
  | Or  of formula * formula
  | Not of formula
  | True
  | False;;

(*1.2 Substitution*)

let rec subst x v = function
  | Var y -> if x = y then v else Var y
  | And (a,b) -> And (subst x v a, subst x v b)
  | Or (a,b) -> Or (subst x v a, subst x v b)
  | Not a -> Not (subst x v a)
  | True -> True | False -> False;;

(* Find a free variable*)

let free_var a =
  let exception Found of var in
  let rec aux = function
    | Var x -> raise(Found x)
    | And (a,b) | Or (a,b) -> aux a; aux b
    | Not a -> aux a
    | True | False -> ()
  in
  try aux a; raise Not_found
  with Found x -> x;;

(*Evaluate a closed formula*)

let rec eval = function
  | Var _ -> assert false
  | And (a,b) -> eval a && eval b
  | Or (a,b)-> eval a || eval b
  | Not a -> not (eval a)
  | True -> true | False -> false;;

(*Satisfiability*)

let rec sat a =
  try
    let x = free_var a in
    sat(subst x True a) || sat (subst x False a)
  with Not_found -> eval a;;

let () =
  let x = Var 0 in
  let x'= Not x in
  let y = Var 1 in
  let y'= Not y in
  let a = And(And(Or(x,y),Or(x',y)),Or(x',y')) in
  let b = And(And(Or(x,y),Or(x',y)),And(Or(x,y'),Or(x',y'))) in
  assert (sat a);
  assert (not (sat b));;


(** DPLL. *)

(** Literal. *)
type literal = bool * var (* false means negated *)

(** Clause. *)
type clause = literal list

(** Clausal formula. *)
type cnf = clause list

let rec list_mem x = function
  | [] -> false
  | y::l -> x = y || list_mem x l

let () =
  assert (list_mem 2 [1;2;3]);
  assert (not (list_mem 5 [1;2;3]));
  assert (not (list_mem 1 []))

let rec list_map f = function
  | [] -> []
  | x::l -> (f x)::(list_map f l)

let () =
  assert (list_map (fun x -> 2*x) [1;2;3] = [2;4;6]);
  assert (list_map (fun _ -> ()) [] = [])
          
let rec list_filter p = function
  | [] -> []
  | x::l -> if p x then x::(list_filter p l) else list_filter p l

let () =
  let even x = x mod 2 = 0 in
  assert (list_filter even [1;2;3;4;6] = [2;4;6])

(** Substitution a[v/x]. *)
let subst_cnf (x:var) (v:bool) (a:cnf) : cnf =
  let a = list_filter (fun c -> not (list_mem (v,x) c)) a in
  list_map (fun c -> list_filter (fun l -> l <> (not v, x)) c) a

(** Simple satisfiability. *)
let rec dpll a =
  if a = [] then true
  else if list_mem [] a then false
  else
    let x = snd (List.hd (List.hd a)) in
    dpll (subst_cnf x false a) || dpll (subst_cnf x true a)

let () =
  let x = true, 0 in
  let x'= false,0 in
  let y = true, 1 in
  let y'= false,1 in
  let a = [[x;y]; [x';y]; [x';y']] in
  let b = [[x;y]; [x';y]; [x;y']; [x';y']] in
  assert (dpll a);
  assert (not (dpll b))

(** Find a unitary clause. *)
let rec unit : cnf -> literal = function
  | [s,x]::_ -> s,x
  | _::a -> unit a
  | [] -> raise Not_found

let () =
  let x = true, 0 in
  let y = true, 1 in
  let y'= false,1 in
  assert (unit [[x;y]; [x]; [y;y']] = x)

(** Find a pure literal in a clausal formula. *)
let pure (a : cnf) : literal =
  let rec clause vars = function
    | [] -> vars
    | (s,x)::c ->
       try
         match List.assoc x vars with
         | Some s' ->
            if s' = s then clause vars c else
              let vars = list_filter (fun (y,_) -> y <> x) vars in
              clause ((x,None)::vars) c
         | None -> clause vars c
       with Not_found -> clause ((x,Some s)::vars) c
  in
  let vars = List.fold_left clause [] a in
  let x, s = List.find (function (_, Some _) -> true | _ -> false) vars in
  let s = match s with Some s -> s | None -> assert false in
  s, x
  
(** DPLL procedure. *)
let rec dpll a =
  if a = [] then true
  else if List.mem [] a then false
  else
    try let s,x = unit a in dpll (subst_cnf x s a)
    with Not_found ->
      try let s,x = pure a in dpll (subst_cnf x s a)
      with Not_found ->
        let x = snd (List.hd (List.hd a)) in
        dpll (subst_cnf x false a) || dpll (subst_cnf x true a)


(** Parse a CNF file. *)
let parse f : cnf =
  let load_file f =
    let ic = open_in f in
    let n = in_channel_length ic in
    let s = Bytes.create n in
    really_input ic s 0 n;
    close_in ic;
    Bytes.to_string s
  in
  let f = load_file f in
  let f = String.map (function '\t' -> ' ' | c -> c) f in
  let f = String.split_on_char '\n' f in
  let f = List.map (String.split_on_char ' ') f in
  let f = List.filter (function "c"::_ | "p"::_ -> false | _ -> true) f in
  let f = List.flatten f in
  let aux (a,c) = function
    | "" -> (a,c)
    | "0" -> (c::a,[])
    | n ->
       let n = int_of_string n in
       let x = if n < 0 then (false,-n) else (true,n) in
       (a,x::c)
  in
  fst (List.fold_left aux ([],[]) f)

let () =
  (* assert (sat (parse "cnf/SAT/ais12.cnf")); *)
  (* assert (sat (parse "cnf/SAT/flat50-1000.cnf")); *)
  (* assert (sat (parse "cnf/SAT/ii8a2.cnf")); *)
  assert (dpll (parse "cnf/SAT/quinn.cnf"));
  (* assert (sat (parse "cnf/SAT/zebra_v155_c1135.cnf")); *)
  (* assert (not (sat (parse "cnf/UNSAT/aim-50-1_6-no-1.cnf"))); *)
  (* assert (not (sat (parse "cnf/UNSAT/bf1355-075.cnf"))); *)
  (* assert (not (sat (parse "cnf/UNSAT/dubois20.cnf"))); *)
  (* assert (not (sat (parse "cnf/UNSAT/dubois21.cnf"))); *)
  (* assert (not (sat (parse "cnf/UNSAT/hole6.cnf"))); *)
  ()

let sudoku cells =
  (* value of cell (i,j) is n *)
  let var ?(neg=false) i j n =
    let i = i mod 9 in
    let j = j mod 9 in
    (not neg, 9*(9*i+j)+n)
  in
  let a = ref [] in
  let add c = a := c :: !a in
  (* at least one number in each cell *)
  for i = 0 to 8 do
    for j = 0 to 8 do
      let c = ref [] in
      for n = 0 to 8 do
        c := (var i j n) :: !c
      done;
      add !c
    done
  done;
  (* each number at most once on a row *)
  for n = 0 to 8 do
    for j = 0 to 8 do
      for i = 0 to 8 do
        for i' = i+1 to 8 do
          add [var ~neg:true i j n ; var ~neg:true i' j n]
        done
      done
    done
  done;
  (* each number at most once on a column *)
  for n = 0 to 8 do
    for i = 0 to 8 do
      for j = 0 to 8 do
        for j' = j+1 to 8 do
          add [var ~neg:true i j n ; var ~neg:true i j' n]
        done
      done
    done
  done;
  (* each number at most once in a subgrid *)
  for n = 0 to 8 do
    for i = 0 to 2 do
      for j = 0 to 2 do
        for di = 0 to 2 do
          for di' = di to 2 do
            for dj = 0 to 2 do
              for dj' = dj to 2 do
                if not (di' = di && dj' = dj) then
                  add [var ~neg:true (3*i+di) (3*j+dj) n ; var ~neg:true (3*i+di') (3*j+dj') n]
              done
            done
          done
        done
      done
    done
  done;
  (* add the cells *)
  for i = 0 to 8 do
    for j = 0 to 8 do
      let n = cells.(i).(j) in
      if n <> 9 then
        add [var i j n]
    done
  done;
  !a
    
(* A simple sudoku:
   +-------+-------+-------+
   | . . 8 | . 9 3 | 5 . . |
   | 6 5 . | 4 . 2 | . . . |
   | . 2 1 | . 8 . | 3 . . |
   +-------+-------+-------+
   | 3 8 . | . 6 . | 2 . 9 |
   | . 7 . | . . . | . 1 . |
   | 1 . 9 | . 4 . | . 7 3 |
   +-------+-------+-------+
   | . . 5 | . 1 . | 7 3 . |
   | . . . | 3 . 9 | . 2 6 |
   | . . 6 | 8 2 . | 1 . . |
   +-------+-------+-------+ *)

let simple_sudoku =
  [|[|9;9;7;9;8;2;4;9;9|];
    [|5;4;9;3;9;1;9;9;9|];
    [|9;1;0;9;7;9;2;9;9|];
    [|2;7;9;9;5;9;1;9;8|];
    [|9;6;9;9;9;9;9;0;9|];
    [|0;9;8;9;3;9;9;6;2|];
    [|9;9;4;9;0;9;6;2;9|];
    [|9;9;9;2;9;8;9;1;5|];
    [|9;9;5;7;1;9;0;9;9|]|]

let () =
  print_string "Checking simple sudoku... ";
  assert (dpll (sudoku simple_sudoku));
  print_endline "done."

(* A medium sudoku:
   +-------+-------+-------+
   | . 2 . | 8 5 4 | . . . |
   | . . . | 6 . . | . . 8 |
   | . 1 . | . . . | . . 9 |
   +-------+-------+-------+
   | 2 . . | . . . | . 9 3 |
   | . 7 5 | 3 . 8 | 6 2 . |
   | 8 9 . | . . . | . . 7 |
   +-------+-------+-------+
   | 4 . . | . . . | . 6 . |
   | 3 . . | . . 2 | . . . |
   | . . . | 7 6 1 | . 4 . |
   +-------+-------+-------+ *)

let medium_sudoku =
  [|[|9;1;9;7;4;3;9;9;9|];
    [|9;9;9;5;9;9;9;9;7|];
    [|9;0;9;9;9;9;9;9;8|];
    [|1;9;9;9;9;9;9;8;2|];
    [|9;6;4;2;9;7;5;1;9|];
    [|7;8;9;9;9;9;9;9;6|];
    [|3;9;9;9;9;9;9;5;9|];
    [|2;9;9;9;9;1;9;9;9|];
    [|9;9;9;6;5;0;9;3;9|]|]

let () =
  print_string "Checking medium sudoku... ";
  flush stdout;
  assert (dpll (sudoku medium_sudoku));
  print_endline "done."
    
(* A hard sudoku:
   +-------+-------+-------+
   | . . . | . 5 . | 9 . . |
   | 9 8 . | . . . | . 5 . |
   | . 4 5 | 7 . . | 3 . . |
   +-------+-------+-------+
   | . . 4 | 2 . . | 8 7 . |
   | . . . | 1 . 4 | . . . |
   | . 7 6 | . . 9 | 1 . . |
   +-------+-------+-------+
   | . . 8 | . . 1 | 6 3 . |
   | . 2 . | . . . | . 8 1 |
   | . . 7 | . 3 . | . . . |
   +-------+-------+-------+ *)

let hard_sudoku =
  [|[|9;9;9;9;4;9;8;9;9|];
    [|8;7;9;9;9;9;9;4;9|];
    [|9;3;4;6;9;9;2;9;9|];
    [|9;9;3;1;9;9;7;6;9|];
    [|9;9;9;0;9;3;9;9;9|];
    [|9;6;5;9;9;8;0;9;9|];
    [|9;9;7;9;9;0;5;2;9|];
    [|9;1;9;9;9;9;9;7;0|];
    [|9;9;6;9;2;9;9;9;9|]|]

let () =
  print_string "Checking hard sudoku... ";
  flush stdout;
  assert (dpll (sudoku hard_sudoku));
  print_endline "done."

(* An unsolvable sudoku:
   https://www.reddit.com/r/sudoku/comments/7q76ay/friend_tells_me_that_this_is_unsolvable_sudoku/
*)
let unsolvable_sudoku =
  [|[|1;9;9;8;9;9;9;9;9|];
    [|9;9;9;9;9;9;9;5;9|];
    [|9;9;9;9;9;0;9;9;9|];
    [|4;9;1;5;9;9;3;9;6|];
    [|9;9;9;9;9;3;0;9;9|];
    [|9;9;9;9;8;7;9;1;2|];
    [|9;9;9;9;9;2;9;7;9|];
    [|9;9;4;9;0;9;9;9;9|];
    [|9;9;6;9;9;9;9;9;9|]|]

let () =
  print_string "Checking unsovable sudoku... ";
  flush stdout;
  assert (not (dpll (sudoku unsolvable_sudoku)));
  print_endline "done."

                            
                           
