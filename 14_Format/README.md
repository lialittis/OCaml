# Format Module

The Format module of OCaml's standard library provides pretty-printing facilitites
to get a fancy display for printing routines.
This module implements a "pretty-printing engine" that is intended to break lines
in a nice way.

## Principles

Line breaking is based on three concepts:

- boxes: a box is a logical pretty-printing unit, which defines a behaviour of 
the pretty-printing engine to display the material inside the box.

- break hints: a break hint is a directive to the pretty-printing engine that
proposes to break the line here, if it is necessary to properly print the rest
of the material.

- indentation rules: a line break occurs, the pretty-printing engines fixes 
the indentation of the new line using indentation reules.

## Boxes

- horizontal box <- *open_hbox*
- vertical box <- *open_vbox*
- vertical/horizontal box <6=- *open_hvbox*
-vertical or horizontal box <- *open_box*

**Exmples:** Suppose we can write 10 chars before the right margin (that 
indicates no more room). We represent any char as a - sign; characters [ and ] 
indicates the opening and closing of a box and b stands for a break hint given 
to the pretty-printing engine.

The output "--b--b--" is displayed like this
- within a "h" box:
`--b--b--`
- within a "v" box:
```
--b
--b
--
```

- within a "hv" box:

1. if there is enough room to print the box on the line:
`--b--b--`

2. But "---b---b---" that cannot fit on the line is written
```
---b
---b
---
```

- within a "hov" box:

`--b--b--`
or
```
---b---b
---
```
or
```
---b
---b
---
```

## Printing spaces

`print_break sp indent`

For instance, if b is `break 1 0` in the output "--b--b--", we get

- witin a "h" box:
`-- -- --`

- within a "v" box:
```
--
--
--
```

- within a “hv” box:
`
-- -- --
`
or, according to the remaining room on the line:
```
--
--
--
```

`print_space ()` that is a convenient abbreviation for `print_break 1 0`
and outputs a single space or break the line


## How to use

This pretty-printing facility is implemented as an overlay on tope of abstract
*formaters* which provide basic output functions. Some formatters qre predefined,
notably:
- Format.std_formater outputs to stdout
- Format.err_formatter outputs to stderr

Most functions in the Format module come in two variants: a short version that 
operates on Format.std_formatter and the generic version prefixed by *pp_* that 
takes a formatter as its first argument.

More formatters can be created with Format.formatter_of_out_channel, 
Format.formatter_of_buffer, Format.formatter_of_symbolic_output_buffer or using 
custom formatters.

**You may consider this module as providing an extension to the printf facility 
to provide automatic line splitting.**

### Printing to stdout: using printf

The format module provides a general printing facility “à la” printf. In addition 
to the usual conversion facility provided by printf, you can write pretty-printing 
indications directly inside the format string (opening and closing boxes, indicating 
breaking hints, etc).

Pretty-printing annotations are introduced by the @ symbol, directly into the string 
format. Almost any function of the format module can be called from within a printf 
format string. For instance

- “@[” open a box (open_box 0). You may precise the type as an extra argument. 
For instance @[<hov n> is equivalent to open_hovbox n.
- “@]” close a box (close_box ()).
- “@ ” output a breakable space (print_space ()).
- “@,” output a break hint (print_cut ()).
- “@;<n m>” emit a “full” break hint (print_break n m).
- “@.” end the pretty-printing, closing all the boxes still opened (print_newline ()).

For instance
```
printf "@[<1>%s@ =@ %d@ %s@]@." "Prix TTC" 100 "Euros";;
Prix TTC = 100 Euros
- : unit = ()
```

### important functions

#### fprintf

val fprintf : formatter -> ('a, formatter, unit) format -> 'a

`fprintf ff fmt arg1 ... argN` formats the arguments arg1 to argN according to the 
format string fmt, and outputs the resulting string on the formatter ff.

The format string fmt is a character string which contains three types of objects: 
plain characters and conversion specifications as specified in the Printf module, 
and pretty-printing indications specific to the Format module.

An complete pretty-printing indications sees in file *pp_indications.md*

#### printf

val printf : ('a, formatter, unit) format -> 'a

Same as fprintf above, but output on std_formatter.


#### pp_print_list
`
val pp_print_list : ?pp_sep:(formatter -> unit -> unit) ->
       (formatter -> 'a -> unit) -> formatter -> 'a list -> unit
`

*pp_print_list ?pp_sep pp_v ppf l* prints items of list l, using pp_v to print 
each item, and calling pp_sep between items (pp_sep defaults to Format.pp_print_cut. 
Does nothing on empty lists.


#### asprintf

val asprintf : ('a, formatter, unit, string) format4 -> 'a

Same as printf above, but instead of printing on a formatter, returns a string 
containing the result of formatting the arguments. The type of asprintf is general 
enough to interact nicely with %a conversions.



## Conclusion of Printing

OCaml has four public modules involving reading and printing: Scanf, Printf, Format and 
Stdlib. Scanf and Printf are flipped in the perspective of reading and writing, while 
Format can be viewed as an enhanced Printf with prettyprint. Scanf has several *scanf 
functions. Printf has *printf functions. Format has *printf and pp_* functions.



## Ref

1. https://ocaml.org/learn/tutorials/format.html
2. https://ocaml.org/api/Format.html
3. http://caml.inria.fr/resources/doc/guides/format.en.html










