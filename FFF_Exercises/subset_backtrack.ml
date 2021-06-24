(* generate a set of all the subset of a set of nums *)

let target = [1;2;3]

(* there is no slice method inside of OCaml, we need to build one *)

let slice (list:'a list) (start:int) (range:int) :'a list =

  let rec drop n list =
    match list with
    | [] -> []
    | _::xs as z -> if n == 0 then z else drop(n - 1)  xs
  in
  let rec take n list =
    match list with
    | [] -> []
    | x::xs -> if n == 0 then [] else x::(take (n - 1) xs)
  in

  take range (drop start list)

(* cut first element of a list*)
let cut = function
  | [] -> []
  | _::xs -> xs


(* another method to slice the slice *)
(*
let slice2 list start toend =
  List.filteri (fun i _ -> ((i >= start) && (i <= toend)))
*)


(* method of backtracking: NOT CORRECT *)
(* 可以用于回文串 *)

let partition (list: int list) : int list list =
  let len = List.length list in
  let rec backtrack (res:int list list) (temlist:int list list) (orilist:int list) (startIndex:int) =
    if startIndex == len then
       temlist@res
    else begin
      let rec loop res temlist orilist startIndex (i:int) =
        let endIndex = startIndex + i in
        if endIndex > len then res
        else begin
          let res =
            backtrack
              res
              ((slice list startIndex i)::temlist)
              orilist
              endIndex
          in
          loop res temlist orilist startIndex (i+1)
        end
      in
      loop res temlist orilist startIndex 1
    end
  in
  backtrack [] [] list 0

(* correct backtrack *)

let subsets list =
  let len = List.length list in
  let rec backtrack res tem ori start len_subset =
    if len_subset == 0 then
      tem::res
    else begin
      let rec loop res tem ori start =
        if start == len then
          res
        else begin
          let res =
            let tem = (List.nth ori start)::tem in
            backtrack res tem ori (start+1) (len_subset-1)
          in
          loop res tem ori (start+1)
        end
      in
      loop res tem ori start
    end
  in
  let rec loop_back res tem ori start len_subset =
    if len_subset > len then res
    else
    (
      let res = backtrack res tem ori start len_subset in
      loop_back res tem ori start (len_subset+1)
    )
  in
  loop_back [] [] list 0 0


(* example *)

let test = partition target
let test2 = subsets target

(* method of DFS *)

(*method of bitvector*)
