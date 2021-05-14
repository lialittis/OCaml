type 'a mylist =
| []
| Cons of 'a * 'a  list

(*let rec list_max = function
| [] -> None
| h::t -> begin
    match list_max t with
    | None -> Some h
    | Some m -> Some (max h m)
  end
*)

let rec list_max:'a list -> 'a option = function
| [] -> None
| h::t -> begin
    match list_max t with
    | None -> Some h
    | Some m -> Some (max h m)
  end
