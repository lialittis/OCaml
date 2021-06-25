open Stdlib
open Str

(* Function to read a frile line by line *)
let read_file file_name =
  let in_channel = open_in file_name in
  try
    while true do
      let line = input_line in_channel in
      print_endline line
    done
  with End_of_file ->
    close_in in_channel

let my_fun () =
  let orig = "My name is Tianchi" in
  let result = Str.global_replace (Str.regexp "Tianchi") "lialittis" orig in
  print_endline result;

  let out_channel = open_out "file" in
  (*output_string out_channel "test";*)
  Printf.fprintf out_channel "%s" "test";
  Printf.eprintf "%s\n" "TEST";
  close_out out_channel;
  let i = 8 and s = "Hi" in
  Printf.fprintf stdout "Number = %d, String = %s\n" i s;
  Printf.printf "printf : Number = %d, String = %s\n" i s

;;
my_fun ()
