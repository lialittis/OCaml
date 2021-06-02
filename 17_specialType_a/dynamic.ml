open Stdlib

type _ ty =
  | TyInt : int ty
  | TyPair : 'a ty * 'b ty -> ('a * 'b) ty

let rec gen : type a. a ty -> a = function
| TyInt -> Random.bits ()
| TyPair (a,b) ->
    (gen a, gen b)

(*gen (TyPair (TyPair (TyInt, TyInt), TyInt));;*)

(* package the type *)
type exty =
  | Ex : 'a ty -> exty

(* a wrong usage : private type escape
 * the output type is 'a ty, which is impossible from exty -> 'a ty *)

(* let f (ex : exty) =
  match ex with
  | Ex ty -> ty
*)

(* Error: This expression has type $Ex_'a ty
 *        but an expression was expected of type 'a
 *        The type constructor $Ex_'a would escape its scope *)

(* one of the solutions *)
let rec show : type a. a ty -> a -> string (**could be another type*) = function
| TyInt -> string_of_int
| TyPair (a,b) -> fun x ->
  Printf.sprintf "(%s,%s)" (show a (fst x)) (show b (snd x))

let f (ex:exty) : string =
  match ex with
  | Ex ty ->
      show ty (gen ty)


(* another solution : package with dynamic value *)
type dyn =
  | ExValue : 'a ty * 'a -> dyn

let f (ex:exty) : dyn =
  match ex with
  | Ex ty ->
      ExValue (ty, (gen ty))

type (_,_) eq = Refl : ('a,'a) eq

let rec equal_ty : type a b. a ty -> b ty -> (a,b) eq option =
  fun a b ->
  match (a,b) with
  | TyInt, TyInt -> Some Refl
  | TyPair (a,b), TyPair (a',b') ->
      begin
      match equal_ty a a' with
      | Some Refl -> (
        match equal_ty b b' with
        | Some Refl -> Some Refl
        | None -> None
      )
      | None -> None
    end
  | _ -> None
