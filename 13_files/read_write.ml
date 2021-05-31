(* Read a file line per line and store every line read in a single list *)
let rec build_list l =
    match input_line ic with
    | line -> build_list (line :: l)
    | exception End_of_file -> close_in ic; List.rev l
