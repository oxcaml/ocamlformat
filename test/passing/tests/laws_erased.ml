(* With [--erase-jane-syntax], laws are removed entirely. *)

let length = List.length

law_? length_nonneg (xs : 'a list) : length xs >= 0

module M = struct
  let x = 1
  law_? trivial : x = 1
end

module type S = sig
  val f : int -> int
  law_? f_id (x : int) : x >= 0 implies_ f x = x [@@attr]
end

(* As for other erased syntax, comments inside a law are kept and attached
   to the surrounding code. *)

law_? (* c1 *) commented x : (* c2 *) x implies_ x

let y = 2
