# Basic constructions

## Helloword

First method:

$vim helloworld.ml
$ocamlc helloworld.ml -o helloworld
$./helloworld


Second method:

$vim helloworld2.ml
  1 #!/usr/bin/ocaml
  2 print_string "Hello World!\n";;
$./helloworld2.ml

Third method:

$vim helloworld3.ml

  1 #!/usr/bin/env utop
  2 print_string "hello world!\n";;

$./helloworld3.ml


## Declarations

### local definitions

let ... in

### unit

let () = function...

