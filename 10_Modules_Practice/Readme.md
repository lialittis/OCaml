# First-Class Modules

You can think of OCaml as being broken up into two parts: 
a core language that is concerned with values and types, 
and a module language that is concerned with modules and 
module signatures. These sublanguages are stratified, in 
that modules can contain types and values, but ordinary 
values can’t contain modules or module types. That means 
you can’t do things like define a variable whose value is 
a module, or a function that takes a module as an argument.

OCaml provides a way around this stratification in the form 
of first-class modules. First-class modules are ordinary 
values that can be created from and converted back to 
regular modules.

First-class modules are a sophisticated technique, and you
’ll need to get comfortable with some advanced aspects of 
the language to use them effectively.


## Working with First-Class Modules

A first-class module is created by packaging up a module 
with a signature that it satisfies. This is done using 
the module keyword.

(module <Module> : <Module_type>)

We can convert a module into a first-class module by let,
And the module type doesn’t need to be part of the 
construction of a first-class module if it can be inferred.

In order to access the contents of a first-class module, 
you need to unpack it into an ordinary module. This can be 
done using the val keyword, using this syntax:

(val <first_class_module> : <Module_type>)
