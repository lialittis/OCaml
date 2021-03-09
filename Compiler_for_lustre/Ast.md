# Abstract Syntac tree

In computer science, an abstract syntax tree (AST), or just syntax tree, is a tree representation of the abstract syntactic structure of source code written in a programming language. Each node of the tree denotes a construct occurring in the source code.

The syntax is "abstract" in the sense that it does not represent every detail appearing in the real syntax, but rather just the structural or content-related details. For instance, grouping parentheses are implicit in the tree structure, so these do not have to be represented as separate nodes. Likewise, a syntactic construct like an if-condition-then expression may be denoted by means of a single node with three branches.

This distinguishes abstract syntax trees from concrete syntax trees, traditionally designated parse trees. Parse trees are typically built by a parser during the source code translation and compiling process. Once built, additional information is added to the AST by means of subsequent processing, e.g., contextual analysis.

Abstract syntax trees are also used in program analysis and program transformation systems.


## Design

The design of an AST is often closely linked with the design of a compiler and its expected features.

Core requirements include the following:

* Variable types must be preserved, as well as the location of each declaration in source code.
* The order of executable statements must be explicitly represented and well defined.
* Left and right components of binary operations must be stored and correctly identified.
* Identifiers and their assigned values must be stored for assignment statements.

These requirements can be used to design the data structure for the AST.

## Module Ast for 3110Caml

module Ast: sig .. end  
This module describes all of the syntactic constructs of our subset of OCaml, 3110Caml. The collection of types in this module completely specifies the abstract syntax tree as well as the type system for the 3110Caml programming language.


### Parts of definition

type constant =  
|	Bool of bool	(*	The Bool constructor represents the 3110Caml constants corresponding to true and false.	*)  
|	Int of int	(*	The Int constructor wraps OCaml integers and corresponds to an integer literal value in 3110Caml.	*)  
|	Nil	(*	Nil is the internal representation of the empty list [].	*)  
|	Unit	(*	This is the constant corresponding the OCaml value (), the only inhabitant of the unit type.	*)  

Constants are the simplest types of expressions in 3110Caml. They correspond to values which may not be altered during program execution.  

type binary_op =   
|	Plus	(*	Plus is the representation of the + operator.	*)  
|	Minus	(*	Minus is the representation of the - operator.	*)  
|	Mult	(*	Mult is the representation of the * operator.	*)  
|	Divide	(*	Divide is the representation of the / operator.	*)  
|	Mod	(*	Mod is the remainder operator mod.	*)  
|	And	(*	And corresponds to logical conjuction operator &&.	*)  
|	Or	(*	Or corresponds to logical disjunction operator ||.	*)  
|	Eq	(*	Eq represents the equality operator, =.	*)  
|	Neq	(*	Eq represents the negation of the equality operator, <>.	*)  
|	Lt	(*	Lt represents the 'less than' comparison operator, <.	*)  
|	Ltq	(*	Ltq represents the 'less than or equal' comparison operator, <=.	*)  
|	Gt	(*	Gt represents the 'greater than' comparison operator, >.	*)  
|	Gtq	(*	Gtq represents the 'greater than or equal' comparison operator, >=.	*)  

The binary_op type is an enumeration of all the valid binary operators in the 3110Caml operators. We support most of the arithmetic, logical, and comparison operators that are valid in OCaml. Like in OCaml, 3110Caml comparison operators are polymorphic.

type typ =  
|	TBool	(*	TBool represents the type bool.	*)  
|	TInt	(*	TInt represents the type int.	*)  
|	TUnit	(*	TUnit represents the type unit.	*)  
|	TList of typ	(*	TList t represents the type t list.	*)  
|	TVar of id	(*	TVar "a" represents the type variable 'a. It is used to implement polymorphism.	*)  
|	Arrow of typ * typ	(*	Arrow are our representations of function types. Arrow (t,t') is the type of a function t -> t'.	*)  

typ is our internal representation of valid 3110Caml types.








