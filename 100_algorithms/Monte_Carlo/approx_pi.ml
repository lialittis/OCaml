let n = read_int ()

let () =
  let p = ref 0 in
  for k = 1 to n do
    let x = Random.float 1. in
    let y = Random.float 1. in
    if (x *. x +. y *. y <= 1.) then
      p := !p + 1
  done;
  let pi = 4. *. float !p /. float n in
  Printf.printf "approxi_pi = %f\n" pi
