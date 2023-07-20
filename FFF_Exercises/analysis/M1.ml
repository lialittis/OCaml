(* Test for Metropolis-Hastings in xynthia *)

let gen_sol f =
  if f > 10. then f /. 100.
  else f *. 17.
;;

let initial_temp () =
  let acceptance = 0.90 in
  let lim = 100 in
  let rec loop acc count sol =
    if count = lim then acc /. float count
    else
      let sol' = gen_sol sol in
      let delta = sol' -. sol in
      (* if sol' > sol, then take the sol' into the loop, and add the delta
         to accumulator *)
      if delta > 0. then loop (acc +. delta) (count + 1) sol'
      (* if not, we still take the sol' into the loop, but don't change the acc *)
      else loop acc count sol'
  in
  let sol = gen_sol 1278. in
  -.(loop 0. 0 sol) /. log acceptance
;;

initial_temp ()
;;


