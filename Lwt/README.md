# Introduction

Lwt offers a third alternative, except using a main loop and using preemptive system threads.
It provides promises, which are very fast: a promise is just a reference that will be filled 
asynchronously, and calling a function that returns a promise does not require a new stack, 
new process, or anything else. It is just a normal, fast, function call. Promises compose 
nicely, allowing us to write highly asynchronous programs.


## Core library

### concepts

`
utop # Lwt_io.read_char;;
- : Lwt_io.input_channel -> char Lwt.t = <fun>
`

It does not return just a character, but something of type `char Lwt.t`. The type `'a Lwt.t` 
is the type of promises that can be fulfilled later with a value of type `'a. Lwt_io.read_char` 
will try to read a character from the given input channel and immediately return a *promise*, 
without blocking, whether a character is available or not. If a character is not available, 
the *promise* will just not be fulfilled yet.

**What we can do with a Lwt promise**

The following code creates a pipe, creates a promise that is fulfilled with the result of 
reading the input side:

```
utop # let ic, oc = Lwt_io.pipe ();;
val ic : Lwt_io.input_channel = <abstr>
val oc : Lwt_io.output_channel = <abstr>
utop # let p = Lwt_io.read_char ic;;
val p : char Lwt.t = <abstr>
utop # Lwt.state p;;
- : char Lwt.state = Lwt.Sleep
```

A promise may be in one of the following states:

- Return x, which means that the promise has been fulfilled with the value x.
- Fail exn, which means that the promise has been rejected with the exception exn.
- Sleep, which means that the promise is has not yet been fulfilled or rejected, so it is pending.

```
utop # Lwt_io.write_char oc 'a';;
- : unit = ()
utop # Lwt.state p;;
- : char Lwt.state = Lwt.Return a
```

After we write something, the reading promise has been fulfilled with the value 'a'.

### Primitives for promise creation

Here are the main primitives:

- Lwt.return : 'a -> 'a Lwt.t : creates a promise which is already fulfilled with the given value
- Lwt.fail : exn -> 'a Lwt.t : creates a promise which is already rejected with the given exception
- Lwt.wait : unit -> 'a Lwt.t * 'a Lwt.u : creates a pending promise, and returns it, paired with 
a resolver (of type 'a Lwt.u), which must be used to resolve (fulfill or reject) the promise.

To resolve a pending promise, use one of the following functions:

- Lwt.wakeup : 'a Lwt.u -> 'a -> unit : fulfills the promise with a value.
- Lwt.wakeup_exn : 'a Lwt.u -> exn -> unit : rejects the promise with an exception.

Note that it is an error to try to resolve the same promise twice. 
Lwt will raise `Invalid_argument` if you try to do so.

> small examples see: https://ocsigen.org/lwt/latest/manual/manual

## The most important operation : bind




















