let m = [| [|1;2;3|];
           [|3;4;5|] |]

let res = m.(1).(0)

(* Bad example : because for all 12 slots in the grand array, 
 * it only construct one same array of 3*)
let m2 = Array.make 12 (Array.make 3 "x")

(* Good example *)
let m3 = Array.make_matrix 12 3 "x"
