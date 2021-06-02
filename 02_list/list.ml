(*List of pairs*)

(*val combine : 'a list -> 'b list -> ('a * 'b) list*)

let c =
  let a = [1;2;3;4] in
  let b = ["a";"b";"c";"d"] in
  List.combine a b

let l = 1::[2]

(* replicate list *)
let rec helper acc n l =
  if n = 0 then acc else helper (l @ acc) (n-1) l
