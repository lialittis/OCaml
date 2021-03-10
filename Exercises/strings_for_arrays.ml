let is_sorted a =
  let l = Array.length a and bool = ref true in
  for i = 0 to l-2 do
    let a1 = a.(i) and a2 = a.(i+1) in
    if (String.compare a1 a2) <> -1 then bool := false 
  done;
  !bool
;;

let find dict word =
  let l = ref 0 and r = ref ((Array.length dict)-1) and result = ref (-1) and count = ref 0 in
  while !l <= !r && !result = (-1) do
    count := !count + 1;
    print_string "Run time: ";
    print_int !count;
    print_newline();
    let temp = (!l + !r) / 2 in
    if dict.(temp) = word then result := temp
    else if dict.(temp) > word then r := (temp - 1) 
    else if dict.(temp) < word then l := (temp + 1)
  done;
  !result
;;

find [|"a"; "b"; "c"|] "a"
;;

find [|"a"; "b"; "c"|] "c"
;;

find [|"a"; "b"; "c"|] "d"
;;

find [||] ""
;;

find [|"d"; "e"; "f"; "g"; "h"; "i"; "j"; "k"; "l"|] "c"
;;
