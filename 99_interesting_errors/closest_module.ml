open Micheline_printer

(*
type location = int

type node = (location, Script.prim) Micheline.node
*)

let pp fmt node = (*Bug*)
  let canonical = Micheline.strip_locations node in
  let printable =
    Micheline_printer.printable
      Michelson_v1_primitives.string_of_prim
      canonical
  in
  Micheline_printer.print_expr fmt printable

let to_string node = (*Bug*)
  pp Format.str_formatter node ;
  Format.flush_str_formatter ()

(* Adapted from Script_ir_translator.parse_ty *)
let rec parse_ty :
    allow_big_map:bool ->
    allow_operation:bool ->
    allow_contract:bool ->
    node ->  (*Bug*)
    Type.Base.t =
 fun ~allow_big_map ~allow_operation ~allow_contract node ->
  match node with
  | Prim (_loc, T_unit, [], _annot) ->
      Type.unit
  | Prim (_loc, T_int, [], _annot) ->
      Type.int
  | Prim (_loc, T_nat, [], _annot) ->
      Type.nat
  | Prim (_loc, T_string, [], _annot) ->
      Type.string
  | Prim (_loc, T_bytes, [], _annot) ->
      Type.bytes
  | Prim (_loc, T_bool, [], _annot) ->
      Type.bool
  | Prim (_loc, T_key_hash, [], _annot) ->
      Type.key_hash
  | Prim (_loc, T_timestamp, [], _annot) ->
      Type.timestamp
  | Prim (_loc, T_mutez, [], _annot) ->
      Type.mutez
  | Prim (_loc, T_option, [ut], _annot) ->
      let ty = parse_ty ~allow_big_map ~allow_operation ~allow_contract ut in
      Type.option ty
  | Prim (_loc, T_pair, [utl; utr], _annot) ->
      let lty = parse_ty ~allow_big_map ~allow_operation ~allow_contract utl in
      let rty = parse_ty ~allow_big_map ~allow_operation ~allow_contract utr in
      Type.pair lty rty
  | Prim (_loc, T_or, [utl; utr], _annot) ->
      let lty = parse_ty ~allow_big_map ~allow_operation ~allow_contract utl in
      let rty = parse_ty ~allow_big_map ~allow_operation ~allow_contract utr in
      Type.union lty rty
  | Prim (_loc, T_set, [ut], _annot) ->
      let ut = parse_ty ~allow_big_map ~allow_operation ~allow_contract ut in
      Type.set ut
  | Prim (_loc, T_map, [uta; utb], _annot) ->
      let uta = parse_ty ~allow_big_map ~allow_operation ~allow_contract uta in
      let utb = parse_ty ~allow_big_map ~allow_operation ~allow_contract utb in
      Type.map uta utb
  | Prim (_loc, T_lambda, [dom; range], _annot) ->
      let dom = parse_ty ~allow_big_map ~allow_operation ~allow_contract dom in
      let range =
        parse_ty ~allow_big_map ~allow_operation ~allow_contract range
      in
      Type.lambda dom range
  | Prim (_loc, T_list, [elt], _annot) ->
      let elt = parse_ty ~allow_big_map ~allow_operation ~allow_contract elt in
      Type.list elt
  | _ ->
      let s = to_string node in
      Stdlib.failwith ("Mikhailsky.parse_ty: could not parse " ^ s)

let global_type =
  parse_ty ~allow_big_map:true ~allow_operation:true ~allow_contract:true node

(* we should notice that, the node noted above are not variable, they are type name
 * if we didn't define a type node in this program, it will take the defination in the
 * cloest module, e.g. module Micheline_printer, then there will be one problem *)
