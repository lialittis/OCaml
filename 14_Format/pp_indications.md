@[: open a pretty-printing box. The type and offset of the box may be optionally specified with the following syntax: the < character, followed by an optional box type indication, then an optional integer offset, and the closing > character. Pretty-printing box type is one of h, v, hv, b, or hov. 'h' stands for an 'horizontal' pretty-printing box, 'v' stands for a 'vertical' pretty-printing box, 'hv' stands for an 'horizontal/vertical' pretty-printing box, 'b' stands for an 'horizontal-or-vertical' pretty-printing box demonstrating indentation, 'hov' stands a simple 'horizontal-or-vertical' pretty-printing box. For instance, @[<hov 2> opens an 'horizontal-or-vertical' pretty-printing box with indentation 2 as obtained with open_hovbox 2. For more details about pretty-printing boxes, see the various box opening functions open_*box.
@]: close the most recently opened pretty-printing box.
@,: output a 'cut' break hint, as with print_cut ().
@ : output a 'space' break hint, as with print_space ().
@;: output a 'full' break hint as with print_break. The nspaces and offset parameters of the break hint may be optionally specified with the following syntax: the < character, followed by an integer nspaces value, then an integer offset, and a closing > character. If no parameters are provided, the good break defaults to a 'space' break hint.
@.: flush the pretty-printer and split the line, as with print_newline ().
@<n>: print the following item as if it were of length n. Hence, printf "@<0>%s" arg prints arg as a zero length string. If @<n> is not followed by a conversion specification, then the following character of the format is printed as if it were of length n.
@{: open a semantic tag. The name of the tag may be optionally specified with the following syntax: the < character, followed by an optional string specification, and the closing > character. The string specification is any character string that does not contain the closing character '>'. If omitted, the tag name defaults to the empty string. For more details about semantic tags, see the functions Format.open_stag and Format.close_stag.
@}: close the most recently opened semantic tag.
@?: flush the pretty-printer as with print_flush (). This is equivalent to the conversion %!.
@\n: force a newline, as with force_newline (), not the normal way of pretty-printing, you should prefer using break hints inside a vertical pretty-printing box.
Note: To prevent the interpretation of a @ character as a pretty-printing indication, escape it with a % character. Old quotation mode @@ is deprecated since it is not compatible with formatted input interpretation of character '@'.

Example: printf "@[%s@ %d@]@." "x =" 1 is equivalent to open_box (); print_string "x ="; print_space ();

   print_int 1; close_box (); print_newline (). It prints x = 1 within a pretty-printing 'horizontal-or-vertical' box.
