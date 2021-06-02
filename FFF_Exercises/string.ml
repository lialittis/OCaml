(*suppose that a variable word exists and is a string*)
(*Define a variable sentence that uses 5 string concatenations to create a string containing 9 times zord, separated by commas ','*)
(*This time, experiment zith defining local let ... in s to stroe the partial results*)


(*If String.concat is allowed*)
let word = "happy"
;;

let sentence = 
  let double_word = String.concat "," [word;word] in 
  let four_word = String.concat "," [double_word;double_word] in
  let five_word = String.concat "," [four_word;word] in
  String.concat "," [four_word;five_word]
;;

(*Of course, here Module String is not allowed*)
let sentence = 
  let head = word^"," in 
  let double =  head^head in
  let four_word = double^double in
  let five_word = four_word^word in
  four_word^five_word
;;
