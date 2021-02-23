let i = 9 and j = 10 in
    if i<j then
      true
    else
      false;;

(* error: unbound value i*)
(*i<j;;*)

let i = 9 and j = 10;;

(* No error*)
i<j;;

i<3;;

if i < j then
  (
    let x = 10 in
    x+2
  )
else
  begin
    let f = 's' in
    4
  end;;

