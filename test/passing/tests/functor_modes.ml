(* modes on functor parameters *)

module F (M : S @ portable) = struct end

module F (M : S @ portable) (M' : S) = struct end

module F (M : S) (M' : S @ portable) @ portable = struct end

module F (M : S @ portable) (M' : S @ portable) : T @ portable = struct
  let g = M.f
end

module F (M : S @ portable contended) (_ : S @ local) () = struct end

module F (M : S @ portable) = M

module F (M : sig
  val f : unit -> unit
end @ portable) = struct end

module F (X : sig val x : int end @ portable) (Y : sig val y : int end) = struct end

module F (X : sig val x : int end @ portable) (Y : S) = struct end

(* long syntax *)

module F : S @ portable -> T @ portable = functor (M : S @ portable) -> struct
  let g = M.f
end

module F : functor (M : S @ stateful) -> (functor () -> sig end) @ stateless =
  functor (M : S @ stateful) () -> struct end

module F (M : S @ read_write) =
  ((functor () -> struct end) : (functor () -> sig end) @ stateless)

module F1 (M1 : S @ stateful) : (functor () -> sig end) @ stateless =
  functor () -> struct end

module M = (functor (M : sig val f : unit -> unit end @ portable) -> struct end) (X)

(* module types *)

module type FT = S @ portable -> T @ portable

module type FT = S @ portable -> S -> T @ portable

module type FT = functor (M : S @ portable) -> T @ portable

module type FT = functor (M : S @ portable) (N : S @ portable) -> T @ portable

module type FT = functor (M : S @ portable) -> functor (N : S @ portable) -> T @ portable

module type FT = functor (M : S @ portable) -> (functor (N : S @ portable) -> T) @ portable

module type FT = functor (M : S) -> sig
  val f : unit -> unit
end @ portable

module type FT = functor (M : sig val f : unit -> unit end @ portable) -> T

module type FT = (functor () () -> sig end) @ local -> sig end

module type FT = (S with type t = int) @ portable -> (S with type t = int) @ portable

module type FT = (module type of M) @ portable -> (S with M) @ portable

module type FT = (S -> S) @ portable -> (S -> S) @ portable

module type Portable_Portable = sig
  module F : functor (M : S @ portable) -> T @ portable
end

module type SigWithModalFunctor2 = sig
  module F : S @ portable -> S @ portable @@ portable
end

(* module types that must be parenthesized to be followed by modes *)

module F (K : (functor () () -> sig end) @ local) = struct
  module (K' @ global) = K ()
end

module F (M : S @ shareable -> S) = (M : S -> S)

module F (M : (S @ portable -> S) -> S) = (M : (S -> S) -> S)

module F (M : (S -> S) @ portable) = (M : (S -> S) @ portable)

module F (M : (S with type t = int) @ portable) = struct end

module F (M : (module type of N) @ portable) = struct end

module F (M : (S with N) @ portable) = struct end

module M : (S -> S) @ portable = F

module M = (F : (S -> S) @ portable) (X)

module M = F ((M : S @ m))

module M = F ((M : sig type t end @ m))

(* let module *)

let () =
  let module F (M : S @ portable) = struct end in
  ()

let () =
  let module F (M : S @ portable) (N : S) : T @ portable = struct end in
  ()

let () =
  let module (F @ stateful) () @ stateless = (functor () -> struct end) in
  let module (M' @ stateless) = F () in
  ()

let () =
  let module F (M : (S -> S) @ portable) = struct end in
  ()

(* long lines *)

module Mmmmmmmmmmmmmmmmmmmmmmmmmmmm (X : Sssssssssssssssssssssssssssss @ portable) : Sssssssssssssssssssssssssssssssssssssss @ portable = M

module type FT = functor (_ : Ssssssssssssssssssssssssssssssssssssssssss) -> Tttttttttttttttt @ portable

module type FT = functor (_ : Ssssssssssssssssssssssssssssssssssssssssss) -> (Tttttttttttttttt with type t = int) @ portable

module type FT = functor (_ : Ssssssssssssssssssssssssssssssssssssssssss @ portable) -> Tttttttttttttttt @ portable

module type FT = functor (Xxxxxxxxxxxxxxxxx : Ssssssssssssssssssssssssssssssssssssssssss @ portable contended) -> Tttttttttttttttt @ portable

(* comments *)

module F ((* 1 *) M (* 2 *) : (* 3 *) S (* 4 *) @ (* 5 *) m (* 6 *)) (* 7 *) : (* 8 *) T (* 9 *) @ (* 10 *) m (* 11 *) = struct end

module type FT = (* 1 *) functor (* 2 *) ( (* 3 *) M (* 4 *) : (* 5 *) S (* 6 *) @ (* 7 *) portable (* 8 *)) (* 9 *) -> (* 10 *) T (* 11 *) @ (* 12 *) portable (* 13 *)

module type FT = S (* 1 *) @ (* 2 *) portable (* 3 *) -> (* 4 *) T (* 5 *) @ (* 6 *) portable (* 7 *)

(* parens in rec *)

module rec M : (S with type t = int) @ m = N

(* attributes *)

module F (M : (S [@a]) @ m) = struct end
module F (M : (sig end [@a]) @ m) = struct end
module F (M : sig [@a] end @ m) = struct end
module type T = functor (M : S) -> (S [@a]) @ m
module M : (S [@a]) @ m = N
module M = (N : (S [@a]) @ m)
