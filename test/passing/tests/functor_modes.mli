module F : S @ portable -> T @ portable

module F : S @ portable -> T @ portable @@ portable

module (F @@ portable) : S @ portable -> T @ portable

module F : functor (M : S @ portable) -> T @ portable

module F (M : S @ portable) : T @ portable

module F (M : S @ portable) (N : S) : T

module F (M : S) (N : S @ portable) : T @ portable

module F (M : (S -> S) @ portable) : (S -> S) @ portable

module F (M : S @ portable) : sig
  val f : unit -> unit
end @ portable

module F (M : sig
  val f : unit -> unit
end @ portable) (N : sig
  val g : unit -> unit
end @ portable) : T @ portable

module rec F : functor (M : S @ portable) -> T @ portable
and G : functor (M : S @ portable) -> T @ portable

module Ffffffffffffffffffffffffffffffff (X : Sssssssssssssssssssssssssssss @ portable) : Sssssssssssssssssssssssssssssssssssssss @ portable
