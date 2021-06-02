let exchange k =
  let decade = (k/10) in
  let unit = (k - decade*10) in
  let output = (unit*10 + decade) in output
;;

let is_valid_answer (grand_father_age, grand_son_age) =
  let exchange_gf_age = exchange grand_father_age and exchange_gs_age = exchange grand_son_age in
  if grand_father_age == grand_son_age * 4 && exchange_gs_age == exchange_gf_age * 3
  then true else false
;;


(*Using reference to solve the problem*)
let find answer =
  let (max,min) = answer and solution = ref (-1,-1) in 
  for gf = min+1 to max do
    for gs = min to gf-1 do 
      if is_valid_answer (gf,gs) 
      then
        solution := (gf,gs)
    done
  done;
  !solution
;;

find (99, 10)
;;

find (62,11)
;;
