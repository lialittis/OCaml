type point2d = int*int
type tetragon = point2d * point2d * point2d * point2d

let pairwise_distinct (lup, rup, llp, rlp) =
  if (lup <> rup) && (lup <> llp) && (lup <> rlp) && (rup <> llp) && (rup <> rlp) && (llp <> rlp)
  then true else false
;;

(*Note that the difference between <> and !=*)


let wellformed (lup, rup, llp, rlp) =
  let (x1,y1) = lup and (x2,y2) = rup and (x3,y3) = llp and (x4,y4) = rlp in
  if x1 < x2 && x1 < x4 && x3 < x2 && x3 < x4 && y1 > y3 && y2 > y4
  then true else false
;;

let rotate_point (x, y) =
  let new_x = +y and new_y = -x in
  (new_x,new_y)
;;

let reorder (p1, p2, p3, p4) =
  let (p1, p2, p3, p4) =
    let (x1,y1) = p1 and (x2,y2) = p2 in 
    if x1 > x2 then
      let temp_p = p1 in
      let p1 = p2 and p2 = temp_p in
      (p1, p2, p3, p4)
    else (p1, p2, p3, p4) in
  let (p1, p2, p3, p4) =
    let (x1,y1) = p1 and (x4,y4) = p4 in
    if x1 > x4 then
      let temp_p = p1 in
      let p1 = p4 and p4 = temp_p in
      (p1, p2, p3, p4)
    else (p1, p2, p3, p4) in
  let (p1, p2, p3, p4) =
    let (x2,y2) = p2 and (x3,y3) = p3 in 
    if x3 > x2 then 
      let temp_p = p3 in
      let p3 = p2 and p2 = temp_p in 
      (p1, p2, p3, p4)
    else (p1, p2, p3, p4) in
  let (p1, p2, p3, p4) =
    let (x3,y3) = p3 and (x4,y4) = p4 in
    if x3 > x4 then
      let temp_p = p3 in
      let p3 = p4 and p4 = temp_p in
      (p1, p2, p3, p4)
    else (p1, p2, p3, p4) in
  let (p1, p2, p3, p4) =
    let (x1,y1) = p1 and (x3,y3) = p3 in
    if y1 < y3 then
      begin 
        let temp_p = p1 in
        let p1 = p3 and p3 = temp_p in
        (p1, p2, p3, p4)
      end
    else (p1, p2, p3, p4) in 
  let (p1, p2, p3, p4) =
    let (x2,y2) = p2 and (x4,y4) = p4 in
    if y2 < y4 then
      let temp_p = p2 in
      let p2 = p4 and p4 = temp_p in
      (p1, p2, p3, p4)
    else (p1, p2, p3, p4) in
  (p1, p2, p3, p4)
;; 

(*The following line only works for rotation*)
(*let new_p1 = p3 and new_p2 = p1 and new_p3 = p4 and new_p4 = p2 in*)




let rotate_tetragon (lup, rup, llp, rlp) =
  if wellformed (lup, rup, llp, rlp) then
    let lup = rotate_point lup and rup = rotate_point rup and llp = rotate_point llp and rlp = rotate_point rlp in
    reorder (lup, rup, llp, rlp)
  else (lup, rup, llp, rlp)
;;

(*Note that if then else should be completed*)

reorder ((35, 9), (4, 12), (37, -17), (0, -22))
;;
