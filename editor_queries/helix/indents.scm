; See: https://docs.helix-editor.com/guides/indent.html

; indent
; ------

[
  ; <..., ...>
  (formals)
  (params)

  ; (...| ...)
  (alt)

  ; misc.
  ; (ternary_expression)
  ; (binary_expression)
  ; (return_statement)
] @indent

; outdent
; -------

[
  "}"
  ")"
  ">"
] @outdent

; align
; -----

; | ... | ...
(rule_body
  . (top_level_term) @anchor
  (#set! "scope" "tail")) @align

; N/A or unused:
; --------------
; indent.always
; outdent.always
; extend
; extend.prevent-once