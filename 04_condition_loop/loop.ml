for i = 0 to 10 do
  print_string "value of i is: ";
  print_int i;
  print_string "\n";
done;;

for i = 10 downto 1 do
  print_string "value of i is: ";
  print_int i;
  print_string "\n";
done;;

(* = checking structural equality - deep*)
(* == checking physical equality*)

let i = 4;;
while i < 5 do
  print_string "test"
done;;
