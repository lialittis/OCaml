open List
open Core

let defaut_list = [1;2;3;4]

let mapi ~f = List.mapi ~f defaut_list

let _ = mapi ~f:(fun i v -> v+i)
