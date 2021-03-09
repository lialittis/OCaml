# OCaml is not simple


## keyword as

The keyword [as] binds a name to all or part of a pattern. Once bound, the name can be used instead of the pattern it represents.   
For example,
	`  
	let rec compress = function  
    | a :: (b :: _ as t) -> if a = b then compress t else a :: compress t  
    | smaller -> smaller;;  
	`
t is bound to the pattern [b::\_].Once t is bound, it can be used in subsequent expressions, as in the rest of the "compress" function. 
