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

if i < j && false then
  (
    let x = 10 in
    x+2
  )
else
  begin
    let f = 3 in
    f+4
  end;;


if i < j || false then
  (
    if j > i then 5 else 6
  )
else
  begin
    let f = 3 in
    f+4
  end;;

