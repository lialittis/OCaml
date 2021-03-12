module SS = Set.Make(String)
;;

let emp = SS.empty;;

let sin = SS.singleton "hello"
;;

let s = List.fold_right SS.add ["hello"; "world"; "community"; "manager"; "stuff"; "blue"; "green"] sin
;;

(* 打印出每个字符串并且在最后换行*)

let print_set s =
  SS.iter print_endline s
;;

let my_filter str =
  String.length str <= 5
;;

let s2 = SS.filter my_filter s
;;


