(*List of pairs*)

(*val combine : 'a list -> 'b list -> ('a * 'b) list*)

let c =
  let a = [1;2;3;4] in
  let b = ["a";"b";"c";"d"] in
  List.combine a b
;;

c
