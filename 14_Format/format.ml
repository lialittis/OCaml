open Format
;;
print_string "long way:\n"

let foo =
  open_box 0;
  print_string "x =";
  print_space ();
  print_int 1;
  close_box ();
  print_newline ()

;;
foo

(*short way*)
;;
print_endline "short way:"


let foo2 =
  printf "@[x =@ %i@]@." 1

;;
foo2

;;
printf "@[<1>%s@ =@ %d@ %s@]@." "Prix TTC" 100 "Euros"





