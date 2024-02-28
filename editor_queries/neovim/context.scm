; See: https://github.com/nvim-treesitter/nvim-treesitter-context/blob/master/CONTRIBUTING.md

; storage types
; -------------

(grammar
  body: (_ (_) @context.end)) @context

; functions
; ---------

(rule
  body: (_ (_) @context.end)) @context

; expressions
; -----------

[
  (params)
  (alt)
] @context
