; NOTE: Order of highlight queries matters, as Tree-sitter uses the first it finds.
; NOTE: Therefore, narrow highlight queries should be placed before broad captures.
; ---------------------------------------------------------------------------------

; attribute
; ---------

(case_name) @attribute

; comment
; -------

[
  (singleline_comment)
  (multiline_comment)
  (rule_descr)
] @comment

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

; string.special
; --------------

(escape_char) @string.special

; string
; ------

[
  (terminal_string)
  (one_char_terminal)
] @string

; type
; ----

(super_grammar
  name: (identifier) @type)

(grammar
  name: (identifier) @type)

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

; punctuation.delimiter
; ---------------------

"," @punctuation.delimiter

; variable.parameter
; ------------------

(formals
  (identifier) @variable.parameter)

; function.method
; ---------------

(rule
  name: (identifier) @function.method)

(term
  base: (identifier) @function.method)

; (identifier) @function.method

; N/A or unused:
; --------------
; tag
; type.builtin
; constructor
; embedded
; function
; variable.builtin
; keyword
; number
; property
; constant.builtin
; constant
; variable
