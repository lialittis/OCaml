let sum_dists ?maxindex dist ar ar' =
    let maxi = match maxindex with
    |Some i -> i
    | None -> Array.length ar
    in
    let rec aux i =
        if i < maxi then
            (dist ar.(i) ar'.(i)) +. (aux (i+1))
        else
            0.
    in
    aux 0

(*
val sum_dists :
  ?maxindex:int -> ('a -> 'b -> float) -> 'a array -> 'b array -> float = <fun>
*)

open Big_int_Z

type t = big_int

module type Dist = sig
  val dist : t -> t -> float
end

let mk_arith () =
  (module struct
    let dist x y = Stdlib.abs_float (Int32.to_float (Int32.sub (Big_int_Z.int32_of_big_int  x) (Big_int_Z.int32_of_big_int y)))
  end:Dist)


