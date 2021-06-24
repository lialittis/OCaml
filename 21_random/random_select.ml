(* A good method for random select from array *)
let random_select (omega: 'a array) =
  let index = Random.int (Array.length omega) in
  omega.(index)

(* note that, we need to re-fresh the Random module every time we use it, for example *)
let f () =
  Random.self_init ();
  let x = [|"a"; "b"; "c"|] in
  random_select x

(* A good method to control the possibility of type of value chosen*)
type t = Int of int| Float of float

let random_terminal ():t =
  let nint = 3 in
  let nfloat = 2 in
  let of_int i = Int i in
  let of_float f = Float f in
  let choice = Random.int (nint + nfloat) in
  if choice < nint then random_select (Array.map of_int [| 1; 2; 3|])
  else random_select (Array.map of_float [|1.;2.;3.|])

(* note that, you shoule keep it well-typed *)
