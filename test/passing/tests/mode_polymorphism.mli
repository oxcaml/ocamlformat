val var : 'a @ 'm -> 'a @ 'm
val bounds : 'a @ [< 'm] -> 'b @ [> 'n] -> 'a @ [> 'n | 'm < portable & 'm]
val canonical : 'a @ [< portable & 'o & past('n) mod portable contended & many & 'm] -> unit
val mixed : 'a @ portable 'm [< 'n] -> unit
val long : 'a @ [< 'mmmmmmmmmmmmmmmm mod portable contended global unique many uncontended stateless immutable & past('nnnnnnnnnnnnnnnnnnnn) > 'oooooooooooooooo | dynamic] -> 'a
val cmts : 'a @ (* 1 *) [< (* 2 *) close('m (* 3 *)) mod (* 4 *) portable & (* 5 *) many (* 6 *)] (* 7 *) -> unit
