


(*-------------------------------------------*)
(*considering that we have the module of State_sapce and all the other modules*)
module State_space = struct
  (*This type is defined in module State_space*)
  type t = {
    typing : Inference.state lazy_t;
    term : Mikhailsky.node;
    target_type : Type.Base.t;
  }
end
let rec proposal ({State_space.term; State_space.target_type(*P1*); _} as current)
  =
  trace current ;
  let rewriting_options = Rules.rewriting current P.rules in
  let rewritings =
    List.fold_left
      (fun rewritings (path, replacement) ->
         let result = Kernel.Rewriter.subst ~term ~path ~replacement in
         let typing =
           Lazy.from_fun (fun () ->
               try P.infer result
               with Inference.Ill_typed_script err ->
                 unrecoverable_failure err current result)
         in
         let target_type = State_space.target_type(*P2*) in
            {State_space.typing; term = result; target_type} :: rewritings)
      []
      rewriting_options
  in
  match rewritings with [] -> proposal current | _ -> uniform rewritings

(*P1: unused variable target_type*)
(*P2: Unbound value State_space.target_type*)
(*solve method: change the second State_space.target_type to target_type*)
