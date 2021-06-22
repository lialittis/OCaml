open Stdlib
(* signature of a module*)
module type X_int = sig val x : int end

(* create a module that matches the signature *)
module Three : X_int  = struct let x = 3 end

let x = Three.x

(* convert Three into a first-class module *)
let three = (module Three : X_int)

module Four = struct let x = 4 end
(* when it could be inferred *)
let numbers = [three ; (module Four)]

(* create a first-class module from an anonymous module *)
let numbers = [three ; (module struct let x = 4 end)]

(* to access the contents of a first-class module *)
module New_three = (val three:X_int)

let x = New_three.x

let to_int m =
  let module M = (val m:X_int) in
  M.x

let plus m1 m2 =
  (module struct
    let x = to_int m1 + to_int m2
  end : X_int
  )
