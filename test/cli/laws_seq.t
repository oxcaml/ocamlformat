Each clause of a law is an [expr], not a [seq_expr], so a sequence must be
parenthesized, both as an assumption and as the conclusion.

  $ echo profile=default > .ocamlformat

  $ echo 'law_? seq (a : bool) : print_endline "x"; a implies_ a' > assumption.ml
  $ ocamlformat assumption.ml
  ocamlformat: ignoring "assumption.ml" (syntax error)
  File "assumption.ml", line 1, characters 40-41:
  1 | law_? seq (a : bool) : print_endline "x"; a implies_ a
                                              ^
  Error: Syntax error
  [1]

  $ echo 'law_? seq (a : bool) : a implies_ print_endline "x"; a' > conclusion.ml
  $ ocamlformat conclusion.ml
  ocamlformat: ignoring "conclusion.ml" (syntax error)
  File "conclusion.ml", line 1, characters 51-52:
  1 | law_? seq (a : bool) : a implies_ print_endline "x"; a
                                                         ^
  Error: Syntax error
  [1]
