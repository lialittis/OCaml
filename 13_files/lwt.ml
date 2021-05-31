#use "topfind"
#require "lwt"
#require "cohttp-lwt-unix"

open Lwt

let main () =
  Lwt_io.open_file ~buffer_size:(4096*8) ~mode:Lwt_io.Input "testlwt/lwtwriting"
  >>= fun data_source
