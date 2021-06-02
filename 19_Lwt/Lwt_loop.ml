open Lwt

let () =
  let rec echo_loop () =
    let%lwt line = Lwt_io.(read_line stdin) in
    if line = "exit" then
      Lwt.return_unit
    else
      let%lwt () = Lwt_io.(write_line stdout line) in
      echo_loop ()
  in

  Lwt_main.run (echo_loop ())
