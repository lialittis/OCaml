(*Tuples in OCAML*)

let max a b = if a > b then a else b;;

let max (a,b) = if a > b then a else b;;

max(4,5);;
max(4.0,2.0);;

let my_fun (i,s,b) = if i > 10 then print_int i else
                       if s = "test" then print_string s else
                         if b then print_string "true" else print_string "false";;

my_fun (44,"hi",true);;
let f = my_fun(44,"hi",true);;
let _ = my_fun(44,"hi",true);;

let fst_of_3tuple (a,b,c) = a;;
let scd_of_3tuple (a,b,c) = b;;
let thd_of_3tuple (a,b,c) = c;;

fst_of_3tuple (44,"hi",true);;

thd_of_3tuple (44,"hi",true);;

let my_tuple = (44,"hi",true);;

my_fun my_tuple;;

print_newline ();;
