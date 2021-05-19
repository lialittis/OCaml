
## Q \& A

I have one function Gen.sampler in type `'a Script_typed_ir.ty -> 'a sampler` ,
and a type `ex_ty = Ex_ty : 'a Script_typed_ir.ty -> ex_ty` , how could I apply
function sampler to values in type `ex_ty` ? The following code won't work
because of the unexpected type of expression `a_ty`  as `$Ex_ty_'a Script_typed_ir.ty`:

```
let test_gen (ex_ty : ex_ty) : 'a sampler =
  match ex_ty with
  | Ex_ty a_ty ->
      Gen.sampler a_ty
  | _ ->
      Stdlib.failwith "unexcepted"
```

Answer:

I'm afraid it won't work no matter how you write it. The problem is: what type
would `test_gen` have? It can't have type `ex_ty -> 'a sampler` because in this
expression `'a` variable is unbound by type of any of arguments, which means it
can be any type the caller would want. However, your implementation's type is
different. `'a`  is bound by a variable that is hidden inside `ex_ty`, which makes
it impossible for the compiler to infer the type `test_gen` should have. A way
around this problem might be to wrap `'a sampler` in an existential type similarly
like `ex_ty` wraps `'a Script_typed_ir.ty`.

Btw. if a type has only one constructor like `ex_ty` does, then you can pattern
match on it immediately in functions header like this:
```
let test_gen (Ex_ty a_ty) = ...
```
But as I said, it won't work in this case because of the type inference problem
I mentioned above.

Another way to think about it is: during compilation all type variables must be
assigned a concrete type. However, when you wrap a value in an existential type
like `ex_ty`, its concrete type is lost forever. You cannot retrieve it and therefore
you cannot use it to type any further values produced from it. You can use it
locally, but you can only depend on its properties that the wrapper guarantees.
So you can pass it into Gen.sampler, but you cannot return the sampler, because
then the type variable would escape its scope.


