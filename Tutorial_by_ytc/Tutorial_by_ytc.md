# OCaml is not simple


## keyword `as`

The keyword [as] binds a name to all or part of a pattern. Once bound, the name can be used instead of the pattern it represents.   
For example,
	`  
	let rec compress = function  
    | a :: (b :: _ as t) -> if a = b then compress t else a :: compress t  
    | smaller -> smaller;;  
	`
t is bound to the pattern [b::\_].Once t is bound, it can be used in subsequent expressions, as in the rest of the "compress" function.



## Module

基本用法：  
每一段代码都被包成一个模块。一个模块可以选择性地作为另外一个模块的子模块，很像文件系统中的目录-但是我们不经常这样做。

当你写一个程序使用两个文件amodule.ml和bmodule.ml，它们中的每一个都自动定义一个模块，名字叫Amodule和Bmodule，模块的内容就是你写到文件中的东西。

> E.g. in amodule.ml
> let hello () = print_endline "Hello"

> in bmodule.ml
> Amodule.hello ()

调用方式：  
模块名字，大写字母开头，点号，值或类型构造器或其他


编译方式：

> ocamlopt -c amodule.ml
> ocamlopt -c bmodule.ml
> ocamlopt -o hello amodule.cmx bmodule.cmx

程序库：  
包括标准库，提供模块的集合。例如，List.iter 表示 List 模块中的iter函数。

open指令：  
> E.g.
> open Amodule;;
> hello ();;

or 避免使用;;
`
open Amodule
let() = 
	hello ()
`

### Interfaces and Signatures

一个模块可以给其他程序提供很多功能（函数，类型，子模块，……）。如果没有什么特别指定，在模块中定义的一切可以从外部访问。这么做在小程序中是一般可以的，但是在很多情况下，一个模块更应该只提供一系列有限（但是有用的）接口，而隐藏一些辅助的函数和类型。

为此，我们得定义模块接口，掩盖模块的实现细节。就像模块从 .ml 文件得到，相应的模块接口或者叫签名从 .mli 文件得到。它包含了一个带有类型的值的列表，及其他。


重新实现 amodule.ml:

> E.g.
> let message = "Hello"
> let hello() = print_endline message

事实上，Amodule有下面的接口：

> val message : string  
> val hello : unit -> unit

* 假设不想让其他模块直接访问message，我们需要定义一个严格的接口来隐藏它。这是我们的amodule.mli文件。

`ocaml
val hello : unit -> unit (** 显示一句问候消息。 *)
`

.mli 文件必须在对应的 .ml 文件之前编译。
它们用ocamlc来编译，而 .ml 文件用ocamlopt来编译成原生码。

`ocaml
ocamlc -c amodule.mli
ocamlopt -c amodule.ml
`

## 抽象类型 Abstract Types

- 类型定义是怎么样的呢？

值可以通过把名字和类型放到.mli文件的方式来导出

> val hello : unit -> unit

模块需要定义新的类型；我们可以定义一个简单的 record 类型，用来表达一个日期。

> type date = {day:int; month: int; year: int}

- 有四个选择编写 .mli 文件:

1. 类型在签名中完全忽略
2. 把类型定义拷贝到签名
3. 类型做成抽象的：只给出名字
4. record的域做成只读的：type date = private { ... }


> e.g. 第三种情况
> type date


现在，这个模块的用户能操作date类型的对象，但是他们不能直接访问record的域，他们必须使用模块提供的函数。假设这个模块提供三个函数，一个用来创建一个日期，一个用来计算两个日期之间的间隔，还有一个用年的形式返回一个日期。

`
type date
val create : ?day:int -> ?months:int -> ?years:int -> unit -> date
val sub : date -> date -> date
val years : date -> float
`

只有create和sub才能用来创建date record。因此，这个模块的用户不可能创建不规范的record。实际上，我们的实现使用record，但是我们可以修改它，并且确保不破坏任何依赖这个模块的代码！这在一个库中很重要，同一个库之后的版本能够暴露同样的接口，同时可以内部改变实现，包括数据结构。

## 子模块(Submodules)

- 模块实现：  
example.ml文件自身就可以代表Example模块。其模块签名是所有定义的符号，又或者可以用一个example.mli文件来约束它。

一个给定的模块也可以在一个文件中显式地定义，成为当前模块的一个子模块。让我们来看看example.ml文件：

`
module Hello = struct
  let message = "Hello"
  let hello () = print_endline message
end
let goodbye () = print_endline "Goodbye"
let hello_goodbye () =
  Hello.hello ();
  goodbye ()
`

从另一个文件中可以看出，很明显我们有两个层次的模块。我们可以这样写：

`
let () =
  Example.Hello.hello ();
  Example.goodbye ()
`

- 子模块接口

我们可以约束一个给定子模块的接口，这叫做模块类型（Module Types）。我们在example.ml文件中做一下:

`
module Hello : sig
 val hello : unit -> unit
end =
struct
  let message = "Hello"
  let hello () = print_endline message
end
(* 在这里 Hello.message 不再能被访问。 *)
let goodbye () = print_endline "Goodbye"
let hello_goodbye () =
  Hello.hello ();
  goodbye ()
`

上面Hello模块的定义和写一对hello.mli/hello.ml文件是等价的。把所有东西写在一个代码块里面是不优雅的，所以我们一般选择单独定义模块签名。

module type Hello_type = sig
 val hello : unit -> unit
end
  
module Hello : Hello_type = struct
  ...
end

Hello_type是一个命名的模块类型，并且可以重用，用来定义其他的模块接口。

虽然子模块在一些情况下可能有用，但是它们和函子一起用的时候效果比较明显。这个下一部分讲。


## Functors (函子，也作仿函数)

函子可能是OCaml中最复杂的特性之一，但是你想成为一个成功的OCaml程序员不需要大量地使用函子。实际上，你可能从来不用自己定义一个函子，不过你确实会在标准库中遇到它们。函子是使用 Set 和 Map 模块的唯一途径，不过使用它们并不困难。

译注：如果你对C衍生的语言比较熟悉而对函数式语言所知甚少，那么可能会对这里的Functors有所误会。在C++，C#，Java都有能够被称作Functor的东西，分别是括号操作符重载，委托（delegate），匿名内部类。但是这里的Functors更加接近lambda表达式，而不是Ocaml中的模块化参数。


* 什么是函子，为什么需要它们？

函子是用另一个模块来参数化的模块，就像函数是用其他的值，也就是参数，来参数化的值一样。

基本上，函子允许传入一个类型作为参数，这个在OCaml中直接做是不可能地。比如说，我们可以定义一个函子接受一个整数 n，返回一系列只能用在长度为 n 的数组上的操作。如果程序员犯错误，把一个常规的数组传给这些操作，则会造成编译错误。如果我们不是使用这个函子，而是标准数组类型，编译器就不能识别出错误，我们将在未来不确定时刻得到运行时错误，这样会更加糟糕。

* 怎么使用现存的函子？

标准库定义了Set模块，它提供了一个Make函子。这个函子接受一个参数，这个参数是一个提供两样东西的模块：用t来给出的元素类型，和用compare给出的比较函数。这个函子的重点是即使程序员犯错误也确保同样的比较函数总是被使用。

举个例子，如果我们要使用整型的集合，我们将会这样做：
`
module Int_set = Set.Make (struct
                             type t = int
                             let compare = compare
                           end)
`

对于字符串的集合甚至更简单，因为标准库提供一个String模块，有一个类型t和一个函数compare。如果你仔细地看下来的话，到现在你肯定会猜怎么去创建一个用来操作字符串集合的模块。

`
 # module String_set = Set.Make (String);;
module String_set :
  sig
    type elt = String.t
    type t = Set.Make(String).t
    val empty : t
    val is_empty : t -> bool
    val mem : elt -> t -> bool
    val add : elt -> t -> t
    val singleton : elt -> t
    val remove : elt -> t -> t
    val union : t -> t -> t
    val inter : t -> t -> t
    val disjoint : t -> t -> bool
    val diff : t -> t -> t
    val compare : t -> t -> int
    val equal : t -> t -> bool
    val subset : t -> t -> bool
    val iter : (elt -> unit) -> t -> unit
    val map : (elt -> elt) -> t -> t
    val fold : (elt -> 'a -> 'a) -> t -> 'a -> 'a
    val for_all : (elt -> bool) -> t -> bool
    val exists : (elt -> bool) -> t -> bool
    val filter : (elt -> bool) -> t -> t
    val partition : (elt -> bool) -> t -> t * t
    val cardinal : t -> int
    val elements : t -> elt list
    val min_elt : t -> elt
    val min_elt_opt : t -> elt option
    val max_elt : t -> elt
    val max_elt_opt : t -> elt option
    val choose : t -> elt
    val choose_opt : t -> elt option
    val split : elt -> t -> t * bool * t
    val find : elt -> t -> elt
    val find_opt : elt -> t -> elt option
    val find_first : (elt -> bool) -> t -> elt
    val find_first_opt : (elt -> bool) -> t -> elt option
    val find_last : (elt -> bool) -> t -> elt
    val find_last_opt : (elt -> bool) -> t -> elt option
    val of_list : elt list -> t
    val to_seq_from : elt -> t -> elt Seq.t
    val to_seq : t -> elt Seq.t
    val add_seq : elt Seq.t -> t -> t
    val of_seq : elt Seq.t -> t
  end
`


* 怎么定义函子

/*TODO*/
/*https://ocaml.org/learn/tutorials/modules.zh.html*/







