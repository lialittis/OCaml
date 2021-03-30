(*open a module*)

(*example*)
List.hd [1;2;3;4];; 

List.tl [1;2;3;4];;

String.get "Test" 3;;(*return the third element*)

String.get "Test" 4;;(*index out of bounds*)


module S = String;;

S.sub "this is a test" 2 6;;


(*open a module, then we don't need to write String dot*)
open String;;
