(* GADTs enable you to tweak your memory *)

(* Controlling memory representation without GADTs *)
(* type 'a t = | Array of 'a array
            | Bytes of bytes *)

(* implement eachof the operations we want on this new array type *)
(*module Compare_array = struct
  type 'a t = | Array of 'a array
              | Bytes of bytes

  let of_bytes x : char t = Bytes x
  let of_array x = Array x

  let length = function
  | Array a -> Array.length a
  | Bytes s -> Bytes.length s

  let get t i =
    match t with
    | Array a -> a.(i)
    | Bytes s -> Bytes.get s i

  let set t i v =
    match t with
    | Array a -> a.(i) <- v
    | Bytes s -> Bytes.set s i v
end*)

module Compare_array:
sig
  type 'a t = Array of 'a array | Bytes of bytes
  val of_bytes : bytes -> char t
  val of_array : 'a array -> 'a t
  val length : 'a t -> int
  val get : char t -> int -> char
  val set : char t -> int -> char -> unit
end = struct
  type 'a t = | Array of 'a array
              | Bytes of bytes

  let of_bytes x : char t = Bytes x
  let of_array x = Array x

  let length = function
  | Array a -> Array.length a
  | Bytes s -> Bytes.length s

  let get t i =
    match t with
    | Array a -> a.(i)
    | Bytes s -> Bytes.get s i

  let set t i v =
    match t with
    | Array a -> a.(i) <- v
    | Bytes s -> Bytes.set s i v

end

;;
let x1 = Compare_array.Array [|1;2;3|] (*int Compare_array.t = Compare_array.Array [|1; 2; 3|]*)

;;
Compare_array.Array [|"one";"two";"three"|](*string Compare_array.t = Compare_array.Array [|"one"; "two"; "three"|]*)

;;
Compare_array.Bytes (Bytes.make 4 'c')(*'_weak2 Compare_array.t = Compare_array.Bytes "cccc"*)

(*problem*)
(*;;
Compare_array.get x1 1
*)

(* It seems pretty good at first glance, but the inferred types aren't quite
 * what we want. In particular, get and set only work with Compare_array containing
 * characters, because of type inference *)


(* OCaml compiler is looking for a single type to assign to the return value
 * for all cases of the match *)


(* One way to work around this problem : as a poor-man's object 
 * Write the code separately for the different cases, and stuff those functions 
 * into a record full of closures *)

module Compare_array_2 :
sig
  type 'a t =
    {
      len : unit -> int;
      get : int -> 'a;
      set : int -> 'a -> unit
    }

  val of_bytes : bytes -> char t
  val of_array : 'a array -> 'a t
  val length : 'a t -> int
  val get : 'a t -> int -> 'a
  val set : 'a t -> int -> 'a -> unit
end = struct
  type 'a t =
    {
      len : unit -> int;
      get : int -> 'a;
      set : int -> 'a -> unit
    }

  let of_bytes s =
    {
      len = (fun () -> Bytes.length s);
      get = (fun i -> Bytes.get s i);
      set = (fun i x -> Bytes.set s i x)
    }

  let of_array a =
    {
      len = (fun () -> Array.length a);
      get = (fun i -> Array.get a i);
      set = (fun i x -> Array.set a i x)
    }

  let length t = t.len ()
  let get t i = t.get i
  let set t i x = t.set i x
end

(* This more or less solves the problem 
 * But we have to allocate three colsures for each Comprare_array_2.t 
 * and the number of closures will only go up as we add more functions 
 * whose behavior depends on the underlying array *)

(* GADTs to the rescue *)
type 'a t = | Array : 'a array -> 'a t
            | Bytes : bytes -> char t

(* The syntax of this declaration suggests thinking about variant constructor
 * like Array or Bytes as functions from the constructor arguments to the type
 * of the resulting value, with the thing to the right of the : *)
;;
Array [|1;2;3|] (*- : int t = Array [|1; 2; 3|]*)

;;
Array [|"one";"two";"three"|](*- : string t = Array [|"one"; "two"; "three"|]*)

;;
Bytes (Bytes.make 4 'c')

(* If we do thing like this *)
let length t =
  match t with
  | Bytes s -> Bytes.length s
  | Array a -> Array.length a

(* the type of length is : char t -> int = <fun> , which is disappointing*)

(* so we do things like this : we need a type variable which might have different
 * values in different branches of a match statement; create a locally-abstract 
 * type el to represent the type parameter of t and the element type and annotating
 * t accordingly.*)
let length (type el) (t:el t) =
  match t with
  | Bytes s -> Bytes.length s
  | Array a -> Array.length a
(* val length : 'el t -> int = <fun> *)

(* then we could push this approach through to get a complete implementation *)

module Compare_array_3 :
sig
  type 'a t = | Array : 'a array -> 'a t
            | Bytes : bytes -> char t
  val of_bytes : bytes -> char t
  val of_array : 'a array -> 'a t
  val length : 'a t -> int
  val get : 'a t -> int -> 'a
  val set : 'a t -> int -> 'a -> unit
end = struct
  type 'a t = | Array : 'a array -> 'a t
              | Bytes : bytes -> char t

  let of_bytes x = Bytes x
  let of_array x = Array x

  let length (type el) (t:el t) =
    match t with
    | Array a -> Array.length a
    | Bytes s -> Bytes.length s

  let get (type el) (t:el t) i : el =
    match t with
    | Array a -> Array.get a i
    | Bytes s -> Bytes.get s i

  let set (type el) (t:el t) i (v:el) =
    match t with
    | Array a -> Array.set a i v
    | Bytes s -> Bytes.set s i v
end

(* it is easy to build abtractions that give us more precises control of 
 * the memory representation *)

(* Let's see the example in Polymorphism *)

type 'a ty =
  | Int_ty : int -> int ty
  | String_ty : string -> string ty
  | Unit_ty : bool -> bool ty

let t = Int_ty 3

let x = String_ty "x"

(* two kinds of syntax *)
let foo : type a. a ty -> bool = function
| Int_ty i -> true
| String_ty s -> true
| Unit_ty u -> true

let foo2 (type a) (ty:a ty) =
  match ty with
  | Int_ty i -> true
  | String_ty s -> true
  | Unit_ty u -> true


