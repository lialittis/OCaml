# dune
dune files are the main part of dune. 
They are used to describe libraries, executables, tests, and 
everything dune needs to know about.



## library

The library stanza must be used to describe OCaml libraries. 
The format of library stanzas is as follows:

```
(library
 (name <library-name>)
 <optional-fields>)
```

<optional-fields> are:

https://dune.readthedocs.io/en/stable/dune-files.html

- (public_name <name>) 
	this is the name under which the library can be referred to as a dependency 
	when it is not part of the current workspace, i.e. when it is installed. 
	Without a (public_name ...) field, the library will not be installed by dune. 
	The public name must start by the package name it is part of and optionally 
	followed by a dot and anything else you want. The package name must be one of 
	the packages that dune knows about, as determined by the <package>.opam files

- (libraries <library-dependencies>) 
	is used to specify the dependencies of the library.

## executable

The executable stanza must be used to describe an executable. The format of executable stanzas is as follows:

```
(executable
 (name <name>)
 <optional-fields>)
```

<optional-fields> are:

- (public_name <public-name>) 
	specifies that the executable should be installed under that name. 
	It is the same as adding the following stanza to your dune file:
```
(install
 (section bin)
 (files (<name>.exe as <public-name>)))
```

- (package <package>) if there is a (public_name ...) field, this specifies 
	the package the executables are part of

- (libraries <library-dependencies>) specifies the library dependencies.

- ...

## executables

The executables stanza is the same as the executable stanza, except that 
it is used to describe several executables sharing the same configuration.

## rule

The rule stanza is used to create custom user rules. 
It tells dune how to generate a specific set of files from a specific set of dependencies.



## OCaml flags

In library, executable, executables and env stanzas, you can specify OCaml compilation 
flags using the following fields:

- (flags <flags>) to specify flags passed to both ocamlc and ocamlopt
- (ocamlc_flags <flags>) to specify flags passed to ocamlc only
- (ocamlopt_flags <flags>) to specify flags passed to ocamlopt only

The default value for (flags ...) is taken from the environment, as a result it is 
recommended to write (flags ...) fields as follows:

- (flags (:standard <my options>))


# dune-project

These files are used to mark the root of projects as well as define project-wide 
parameters. The first line of dune-project must be a lang stanza with no extra 
whitespace or comments. The lang stanza controls the names and contents of all 
configuration files read by Dune and looks like:

- (lang dune 2.8)

Additionally, they can contains the following stanzas.

## name

Sets the name of the project. This is used by dune subst and error messages.

(name <name>)

## version

(version <version>)

## generate_opam_files

Dune is able to use metadata specified in the dune-project file to generate 
.opam files. To enable this integration, add the following field to the 
dune-project file:

(generate_opam_files true)

Dune uses the following global fields to set the metadata for all packages 
defined in the project:

- (license <name>) - Specifies the license of the project, 
	ideally as an identifier from the SPDX License List
- (authors <authors>) - A list of authors
- (maintainers <maintainers>) - A list of maintainers
- (source <source>) - where the source is specified two ways: 
	(github <user/repo>) or (uri <uri>)
- (bug_reports <url>) - Where to report bugs. 
	This defaults to the GitHub issue tracker if the source is specified as a GitHub repository
- (homepage <url>) - The homepage of the project
- (documentation <url>) - Where the documentation is hosted

With this fields in, every time dune is called to execute some rules 
(either via dune build, dune runtest or something else), the opam files get generated.

Some or all of these fields may be overridden for each package of the project, see package.


## packages

## Others

https://dune.readthedocs.io/en/stable/dune-files.html#dune-project

# Examples

## Quick Start

### hello_world

After building the executable file, the executable will be built as 
`_build/default/hello_world.exe`. Note that native code executables will have 
the `.exe` extension on all platforms. The executable can be built and run in 
a single step with `dune exec ./hello_world.exe`.

### hello_world with Lwt

Add libirary of lwt.unix

### Defining a library using Lwt and ocaml-re

The library defined will be composed of all the modules in the same directory.
Outside of the library, module Foo will be accessible as Mylib.Foo, unless you
write an explicit mylib.ml file.

We can then use this library in any other directory by adding `mylib` to the 
(libraries ...) field.

### Setting the OCaml comilation flags globally





