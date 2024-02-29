; NOTE: Neovim's highlight order differs from Tree-sitter's and Helix's,
; NOTE: as broad captures should be placed first, narrow queries - second.
; See: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#highlights
; ----------------------------------------------------------------------------------------------

; variable.parameter
; ------------------

(formals
  (identifier) @variable.parameter)

; punctuation.delimiter
; ---------------------

"," @punctuation.delimiter

; punctuation.bracket
; -------------------

[
  "<"
  ">"
  "{"
  "}"
] @punctuation.bracket

(alt
  "(" @punctuation.bracket
  ")" @punctuation.bracket)

; operator
; --------

[
  ; "=" ":=" "+="
  (define) (override) (extend)

  ; "&" "~"
  (lookahead) (negative_lookahead)

  ; "#"
  (lexification)

  ; "*" "+" "?"
  (zero_or_more) (one_or_more) (zero_or_one)

  ; "..."
  (super_splice)

  "<:" ".." "|"
] @operator

; type
; ----

(super_grammar
  name: (identifier) @type)

(grammar
  name: (identifier) @type)

; string
; ------

[
  (terminal_string)
  (one_char_terminal)
] @string

; string.escape
; -------------

(escape_char) @string.escape

; function.method.call
; --------------------

(term
  base: (identifier) @function.method.call)

; function.builtin
; ----------------

; Lexical
((identifier) @function.builtin
  (#match? @function.builtin "^(any|alnum|end|digit|hexDigit|letter|space|lower|upper|caseInsensitive|listOf|nonemptyListOf|emptyListOf|applySyntactic)$")
  (#is-not? local))

; Syntactic
((identifier) @function.builtin
  (#match? @function.builtin "^(ListOf|NonemptyListOf|EmptyListOf)$")
  (#is-not? local))

; function.method
; ---------------

(rule
  name: (identifier) @function.method)

; comment
; -------

(singleline_comment) @comment @spell

; comment.documentation
; ---------------------

[
  (multiline_comment)
  (rule_descr)
] @comment.documentation @spell

; attribute
; ---------

(case_name) @attribute
