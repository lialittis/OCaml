type point  = { x : float; y : float; z : float }
type dpoint = { dx : float; dy : float; dz : float }
type physical_object = { position : point; velocity : dpoint }

let move p dp =
  {x = p.x +. dp.dx; y = p.y +. dp.dy ; z = p.z +. dp.dz };;

let next obj =
  {position = move obj.position obj.velocity; velocity = obj.velocity};;


(*Note that there we use the self defined square function
and we should *)
let will_collide_soon p1 p2 =
  let next_p1 = next p1 and next_p2 = next p2 in
  let square x = x *. x in
  let dis = sqrt (square (next_p1.position.x -. next_p2.position.x)
                  +. square (next_p1.position.y -. next_p2.position.y)
                  +. square (next_p1.position.z -. next_p2.position.z)) in
  if dis <= 2.0 then true else false
;;

will_collide_soon
  {position = {x = -0.552; y = 1.746; z = -0.440};
   velocity = {dx = -0.453; dy = -0.996; dz = -0.893}}
  {position = {x = -0.967; y = 0.186; z = 0.261};
   velocity = {dx = 0.212; dy = 0.324; dz = 0.267}}
;;

will_collide_soon
  {position = {x = -0.771; y = 1.144; z = -0.130};
   velocity = {dx = 0.737; dy = -0.177; dz = -0.017}}
  {position = {x = -1.703; y = 0.203; z = 0.865};
   velocity = {dx = -0.570; dy = 0.748; dz = 0.498}}
;;
