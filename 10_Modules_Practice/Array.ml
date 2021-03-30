(*type 'a t = 'a array*)
let a = [|0;1;2|];;

(*val length : 'a array -> int*)
let len = Array.length a;;

let firstitem = Array.get a 0;;

let modifylast = Array.set a 2 firstitem;;

a;;

let modify_no_exist = Array.set a 3 0;;
(*Exception: Invalid_argument "index out of bounds"*)

(*append*)


(*sort*)

