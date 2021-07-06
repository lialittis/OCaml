(* exemple.ml *)

let verbose = ref false
let max_files_to_list = ref 1
let dir_to_list = ref "."
let time_hours = ref 0
let time_minutes = ref 0
    
let sort_files = function
  "alpha" -> print_endline "Alpha sort"
| "chrono" -> print_endline "Chrono sort"
| "owner" -> print_endline "Owner sort"
| _ -> raise (Arg.Bad("Shouldn't happen"))
         
let main =
begin
  let speclist = [("-v", Arg.Set verbose, "Enables verbose mode");
                  ("-n", Arg.Set_int max_files_to_list, "Sets maximum number of files to list");
                  ("-d", Arg.Set_string dir_to_list, "Names directory to list files");
                  ("-t", Arg.Tuple ([Arg.Set_int time_hours ; Arg.Set_int time_minutes]), "Sets creation hours and minutes listed files have to match");
                  ("-s", Arg.Symbol (["alpha"; "chrono"; "owner"], sort_files), " Allows to sort listed files alphabetically, chronologically, or by owner");
                  ("--", Arg.Rest (fun arg -> print_endline ("The rest contains: " ^ arg)), "Stop interpreting keywords and prints the rest");
                 ]
  in let usage_msg = "MyLs2000 is a revolutionary file listing tool. Options available:"
  in Arg.parse speclist (fun anon -> print_endline ("Anonymous argument: " ^ anon)) usage_msg;
  print_endline ("Verbose mode: " ^ string_of_bool !verbose);
  print_endline ("Max files to list: " ^ string_of_int !max_files_to_list);
  print_endline ("Directory to list files: " ^ !dir_to_list);
  print_endline ("Time of files to list: " ^ string_of_int(!time_hours) ^ ":" ^ string_of_int(!time_minutes));
end

let () = main
