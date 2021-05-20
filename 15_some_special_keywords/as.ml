(*Example of as*)
let rec compress = function
| a :: (b :: _ as t) -> if a = b then compress t else a :: compress t
| smaller -> smaller;;

module Space = {
  value : Int.t;
  path : String.t;
}

(*need to correct*)

let foo ({space.value;_} as tem) =
  print_int tem.value;
  print_string tem.path
