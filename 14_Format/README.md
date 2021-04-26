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



## Ref

https://ocaml.org/learn/tutorials/format.html












