# General input functions

val open_in : string -> in_channel

val open_in_bin : string -> in_channel

val input_char : in_channel -> char

val input_line : in_channel -> string

val input : in_channel -> bytes -> int -> int -> int

> input ic buf pos len reads up to len characters from the given channel ic, storing them in byte sequence buf, starting at character number pos. It returns the actual number of characters read, between 0 and len (inclusive). A return value of 0 means that the end of file was reached. A return value between 0 and len exclusive means that not all requested len characters were read, either because no more characters were available at that time, or because the implementation found it convenient to do a partial read; input must be called again to read the remaining characters, if desired.

val really_input : in_channel -> bytes -> int -> int -> unit

> really_input ic buf pos len reads len characters from channel ic, storing them in byte sequence buf, starting at character number pos.

> Raises

> End_of_file if the end of file is reached before len characters have been read.
Invalid_argument if pos and len do not designate a valid range of buf.


val really_input_string : in_channel -> int -> string

> really_input_string ic len reads len characters from channel ic and returns them in a new string.

val in_channel_length : in_channel -> int

> Return the size (number of characters) of the regular file on which the given channel is opened. If the channel is opened on a file that is not a regular file, the result is meaningless. The returned size does not take into account the end-of-line translations that can be performed when reading from a channel opened in text mode.

