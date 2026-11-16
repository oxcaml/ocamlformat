Known limitation: erasing a documented law can attach its docstring to the
next declaration, causing the AST check to fail.

  $ echo profile=default > .ocamlformat

  $ cat > docs.ml <<'EOF'
  > (** Documents the law, not x. *)
  > law_? documented : true
  > 
  > let x = 0
  > EOF
  $ ocamlformat --erase-jane-syntax docs.ml
  ocamlformat: Cannot process "docs.ml".
    Please report this bug at https://github.com/ocaml-ppx/ocamlformat/issues.
  [1]

Disabling comment checks exposes the unwanted reattachment.

  $ ocamlformat --erase-jane-syntax --no-comment-check docs.ml
  (** Documents the law, not x. *)
  let x = 0

The same issue occurs in signatures.

  $ cat > docs.mli <<'EOF'
  > (** Documents the law, not x. *)
  > law_? documented : true
  > 
  > val x : int
  > EOF
  $ ocamlformat --erase-jane-syntax docs.mli
  ocamlformat: Cannot process "docs.mli".
    Please report this bug at https://github.com/ocaml-ppx/ocamlformat/issues.
  [1]
  $ ocamlformat --erase-jane-syntax --no-comment-check docs.mli
  val x : int
  (** Documents the law, not x. *)

When there is no surviving declaration, erasure also fails rather than
preserving the docstring on its own.

  $ cat > only.ml <<'EOF'
  > (** Only the law. *)
  > law_? documented : true
  > EOF
  $ ocamlformat --erase-jane-syntax only.ml
  ocamlformat: Cannot process "only.ml".
    Please report this bug at https://github.com/ocaml-ppx/ocamlformat/issues.
    BUG: comment changed.
  File "only.ml", line 1, characters 0-20:
  Error: comment (*  Only the law.  *) dropped.
  [1]
  $ cp only.ml only.mli
  $ ocamlformat --erase-jane-syntax only.mli
  ocamlformat: Cannot process "only.mli".
    Please report this bug at https://github.com/ocaml-ppx/ocamlformat/issues.
  [1]
