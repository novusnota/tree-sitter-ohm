; See: https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects

; function.inner & outer
; ----------------------

(rule
  body: (_) @function.inner) @function.outer

; class.inner & outer
; -------------------

(grammar
  body: (grammar_body . "{" . (_) @_start @_end (_)? @_end . "}")
  (#make-range! "class.inner" @_start @_end)) @class.outer

; attribute.inner & outer
; -----------------------

(case_name
  (identifier) @attribute.inner) @attribute.outer

; call.inner & outer
; ------------------

(term
  base: (identifier)
  (params . "<" .  (_) @_start (_)? @_end . ">")
  (#make-range! "call.inner" @_start @_end)) @call.outer

; parameter.inner & outer
; -----------------------

(formals
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(rule_body
  ((_) @parameter.inner . "|"? @parameter.outer) @parameter.outer)

(params
  ((_) @parameter.inner . ","? @parameter.outer) @parameter.outer)

(alt
  ((_) @parameter.inner . "|"? @parameter.outer) @parameter.outer)

; assignment.inner & outer w/ lhs & rhs
; -------------------------------------

(rule
  name: (_) @assignment.lhs
  case: (_) @assignment.inner
  body: (_) @assignment.rhs) @assignment.outer

; comment.inner & outer
; ---------------------

(singleline_comment) @comment.inner
(singleline_comment)+ @comment.outer

(multiline_comment) @comment.inner
(multiline_comment)+ @comment.outer
