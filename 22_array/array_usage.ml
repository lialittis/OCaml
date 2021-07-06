(* A good usage for array, to generate an array containing variant types *)
type t = Type1 | Type2 | Type3

let of_int = function 0 -> Type1 | 1 -> Type2 | 2 -> Type3 | _ -> assert false

let number_of_types = 3

let omega = Array.init number_of_types of_int
(* val omega : t array = [|Type1; Type2; Type3|] *)
