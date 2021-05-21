type date =
  { year : int; month : int; day : int;
    hour : int; minute : int }

let the_origin_of_time =
  { year = 1; month = 1; day = 1;
    hour = 0; minute = 0 }

let wellformed date =
  if date.year >= 1 && date.month >= 1 && date.month <= 5 && date.day >= 1
     && date.day <= 4 && date.hour >= 0 && date.hour <= 2 && date.minute >= 0
     && date.minute <= 1 then true else false
;;


(*Note that, if there is no keyword multable, the value of records cannot be modified*)
let next date =
  match date with
  | {minute = 1} -> begin match date with
      | {hour = 2} -> begin match date with
          | {day = 4} -> begin match date with
              | {month = 5} -> { year = date.year + 1; month = 0; day = 0;
                                 hour = 0; minute = 0 }
              | _ -> { year = date.year; month = date.month+1; day = 0;
                       hour = 0; minute = 0 }
            end
          | _ -> { year = date.year; month = date.month; day = date.day + 1;
                   hour = 0; minute = 0 }
        end
      | _ -> { year = date.year; month = date.month; day = date.day;
               hour = date.hour + 1; minute = 0 }
    end
  | _ -> { year = date.year; month = date.month; day = date.day;
           hour = date.hour; minute = date.minute + 1 }
;; 


let of_int minutes =
  let year = minutes / (5*4*3*2) in
  let month = (minutes - year*5*4*3*2) / (4*3*2) in
  let day = (minutes - year*5*4*3*2 - month*4*3*2) / (3*2) in
  let hour = (minutes - year*5*4*3*2 - month*4*3*2 - day*3*2) / 2 in
  let minute = minutes - year*5*4*3*2 - month*4*3*2 - day*3*2 - hour *2 in
  { year = year+1; month = month+1; day = day+1;
    hour = hour; minute = minute}
;;


wellformed {year = 1; month = 1; day = 1; hour = 0; minute = 0}
;;

wellformed {year = 0; month = 5; day = 3; hour = 0; minute = 2}
;;

next {year = 6; month = 4; day = 4; hour = 1; minute = 1}
;;

next {year = 2; month = 1; day = 4; hour = 0; minute = 0}
;;

of_int 95
;;

of_int 110
;;
