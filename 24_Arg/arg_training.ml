(* set up the usage message to printed in the case of a malformed command line *)

let usage_msg = "append [-verbose] <file1> [<file2>] ... -o <output>"

(* create some references to hold the information grthered from the command line *)
let verbose = ref false
let input_files = ref []
let output_file = ref ""

(* now, we have a boolean reference for the -verbose flag with a default value of false 
   and a ref to a list which will hold the names of all the input files. *)

(* handle the anonymous inputs *)
let anon_fun filename =
  input_files := filename :: !input_files

(* list of command line flag specifications *)
let speclist =
  [("-verbose", Arg.Set verbose, "Output debug information");
   ("-o", Arg.Set_string output_file, "Set output file name")]

(* the Arg.Set action which sets a boolean reference, and the Arg.Set_string action 
   which sets a string reference. Our input_files reference will of course be updated 
   by the anon_fun function already defined.*)

let () = Arg.parse speclist anon_fun usage_msg
