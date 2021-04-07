# Module Asttypes

module Asttypes: sig .. end

Auxiliary AST types used by parsetree and typedtree.

Warning: this module is unstable and part of compiler-libs.

type constant = 
|	Const_int of int
|	Const_char of char
|	Const_string of string * Location.t * string option
|	Const_float of string
|	Const_int32 of int32
|	Const_int64 of int64
|	Const_nativeint of nativeint

type rec_flag = 
|	Nonrecursive
|	Recursive

type direction_flag = 
|	Upto
|	Downto

type private_flag = 
|	Private
|	Public

type mutable_flag = 
|	Immutable
|	Mutable

type virtual_flag = 
|	Virtual
|	Concrete

type override_flag = 
|	Override
|	Fresh

type closed_flag = 
|	Closed
|	Open

type label = string 

type arg_label = 
|	Nolabel
|	Labelled of string
|	Optional of string

type 'a loc = 'a Location.loc = {
  	txt : 'a;
  	loc : Location.t;
}

type variance = 
|	Covariant
|	Contravariant
|	Invariant
