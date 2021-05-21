(* in type of 'a ty *)
type 'a list_generator = int -> 'a list
let gen_n n v =
  let l = ref [] in
  for i = 1 to n do l := v :: !l; done;
  !l
;;
let gen_int:(int list_generator) = fun n ->
  gen_n n 1
;;
let gen_char:(char list_generator) = fun n -> gen_n n 'c';;
