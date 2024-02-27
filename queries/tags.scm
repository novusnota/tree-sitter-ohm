; See: https://tree-sitter.github.io/tree-sitter/code-navigation-systems

; Class definitions         @definition.class
; -------------------------------------------

(
  (multiline_comment)* @doc
  .
  (grammar
    name: (identifier) @name) @definition.class
  (#strip! @doc "^[\\s\\*/]+|^[\\s\\*/]$")
  (#select-adjacent! @doc @definition.class)
)


; Method definitions        @definition.method
; --------------------------------------------

(
  (multiline_comment)* @doc
  .
  (rule
    name: (identifier) @name) @definition.method
  (#strip! @doc "^[\\s\\*/]+|^[\\s\\*/]$")
  (#select-adjacent! @doc @definition.method)
)


; Function/method calls     @reference.call
; -----------------------------------------

(
  (term
    base: ((identifier) @name) @reference.call)
)


; Class reference           @reference.class
; ------------------------------------------

(
  (super_grammar
    name: (identifier) @name) @reference.class
)
