let gen_next_id =
  let cpt = ref 0 in
  fun n -> incr cpt;
  n^"_next"^(string_of_int !cpt)
;;

gen_next_id "f"
;;

