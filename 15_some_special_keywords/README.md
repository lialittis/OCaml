
# Type expression

## as

The Inria manual shows that the “as” keyword can be used as part of a type expression. 


### A good example

In the answers for the tutorials for OCaml available at [this site](https://ocaml.org/learn/tutorials/99problems.html), 
some of the solutions, including the one for eliminating consecutive duplicates of list elements, 
is written as such:

```ocaml
let rec compress = function
    | a :: (b :: _ as t) -> if a = b then compress t else a :: compress t
    | smaller -> smaller;;
```
What is the relevance of the line a :: (b:: _ as t)? Why can't I write it as a :: b :: t instead?

**Answer**

The t in b :: _ as t is bound to b :: _ . So the meaning is different. 
If you use the pattern a :: b :: t you would need to say compress (b :: t), which is a little less 
elegant and a tiny bit less efficient.

**The keyword `as` binds a name to all or part of a pattern.** Once bound, the name can be used 
instead of the pattern it represents. In your "compress" function, t is bound to the pattern `b :: _`. 
Once t is bound, it can be used in subsequent expressions, as in the rest of the "compress" function.

`as` name binding occurs left-to-right, unlike most languages (excepting C's typedef). 
Also, `::` appears to have higher precedence than `as`.

Therefore, `(b :: _ as t)` is equivalent to `((b :: _) as t)`. This can be confusing for those used 
to right-to-left bindings. Note that `a :: (b :: _) as t` will bind the whole pattern `a :: b :: _` to `t`, 
due to the precedence mentioned above.


