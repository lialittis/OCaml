# Modules

## Set

如下创建一个字符串集合：
`
 # module SS = Set.Make(String);;
module SS :
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

然后新建一个空集：
`
 # let s = SS.empty;;
val s : SS.t = <abstr>
`

不过我们也可以选择创建一个只包含一个元素的集合：

`
 # let s = SS.singleton "hello";;
val s : SS.t = <abstr>
`

我们还可以向集合中加入元素：

`
 # let s =
    List.fold_right SS.add ["hello"; "world"; "community"; "manager";
                            "stuff"; "blue"; "green"] s;;
val s : SS.t = <abstr>
`

我们可以通过一个函数来打印一个集合的内容：

`
 # (* 打印出每个字符串并且在最后换行 *)
  let print_set s = 
     SS.iter print_endline s;;
val print_set : SS.t -> unit = <fun>
`

我们可以通过remove函数移除某个元素。但是当我们想移除很多元素的时候，我们更应该使用filter。 下面我们将filter掉长度大于5的字符串：

`
 # let my_filter str =
    String.length str <= 5;;
val my_filter : string -> bool = <fun>
`

`
 # let s2 = SS.filter my_filter s;;
val s2 : SS.t = <abstr>
`

用匿名函数(lambda)往往简洁：

`
 # let s2 = SS.filter (fun str -> String.length str <= 5) s;;
val s2 : SS.t = <abstr>
`

如果我们想看看某个元素是否在集合内，我们可以这么做：

`
 # SS.mem "hello" s2;;
- : bool = true
`
Set模块提供了很多集合论的一些操作，如并，交，差等。比如说我们可以作原集合与字符串长度小于5的集合的差：

`
# print_set (SS.diff s s2);;
community
manager
- : unit = ()
`
* 要注意的是，Set模块是纯函数式的，每个修改操作都会创建一个新的集合，而不会修改原来的集合。




