let min a =
  let rec aux i m =
    if i < Array.length a then
      if a.(i) < m then aux (succ i) a.(i)
      else aux (succ i) m
    else m
  in
  (aux 1 a.(0));;

let min_index a =
  let rec aux i imin m =
    if i < Array.length a then
      if a.(i) < m then aux (succ i) (i) a.(i)
      else aux (succ i) (imin) m
    else imin
  in
  aux 1 0 a.(0);;

let it_scales =
  "NO";;
