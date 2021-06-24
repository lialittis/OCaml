 module type Dist = sig
  val dist : string -> string -> float
end



(* Typically Hamming distance is undefined when strings are of different length *)
let mk_hamming () =
  (module struct
    exception Length_Diff
    let dist x y =
      if String.length x != String.length y then
        raise Length_Diff
      else (
        let len = String.length x in
        let rec aux dist i len =
          if i = len then dist
          else begin
            if x.[i] == y.[i] then aux dist (i+1) len
            else aux (dist+1) (i+1) len
          end
        in
        Float.of_int (aux 0 0 len)
      )
  end : Dist)

let distance = mk_hamming ()

let functorx (module D:Dist) = D.dist "123" "123"

let rest = functorx distance

(* Module cannot be used in this way, it should be contained inside of a Functor*)
(* let x = distance.dist "123" "213"*)
