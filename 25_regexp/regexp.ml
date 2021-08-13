#load "str.cma";;

let r = Str.regexp "hello \\([A-Za-z]+\\)"

let x1 =Str.replace_first r "\\1" "hello world" 

let x2 = print_endline x1
(* to run : ocamlc str.cma regexp.ml*)
