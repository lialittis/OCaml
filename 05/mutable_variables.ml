let x = 5;;
let t = ();;

let x = ref 5;;
!x;;(*get the value of x*)
let s = ref "str";;
!s;;

x := 3;;(*update the value of x*)
!x;;
x;;
s := "STR";;
!s;;
s;;

while !x< 10 do
  print_string "Hello world\n";
  x := !x + 1;
done;;

!x;;

let f1' = ref 3.4 and f2' = ref 3.4;;

(*test equality*)

f1' = f2';; (*strucally equal*)

f1' == f2';; (*physically not equal*)

f1' <> f2';;(*strucally equal*)

f1' != f2';;(*physicall not equal*)
