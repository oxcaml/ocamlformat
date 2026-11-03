(* Code blocks in comments are formatted, and the formatter rewrites legacy
   [local_] and [global_] syntax into modes and modalities. The comment check
   must treat the legacy and modal forms as equal. *)

(* Expressions:

   {[
     let () = f (local_ x)

     let () =
       let (counter : int ref) = local_ ref 0 in
       let { a; b } = local_ { a = 1; b = 2 } in
       if bar then (local_ qux) ;
       if baz then (local_ qux)
   ]} *)

(* Let bindings:

   {[
     let () =
       let local_ x = 1 in
       let local_ y : int = 2 in
       x + y
   ]} *)

(* Parameters:

   {[
     let f (local_ x) ~(local_ y) ?(local_ z = 1) (local_ (w : int)) = x
   ]} *)

(* Function bodies:

   {[
     let f x = local_ g x

     let h = fun x -> local_ x
   ]} *)

(* Types:

   {[
     type t = {global_ a: int; b: int}

     type u = A of global_ int * int

     type v += B of global_ int

     module type S = sig
       val f : local_ int -> local_ int
     end
   ]} *)
