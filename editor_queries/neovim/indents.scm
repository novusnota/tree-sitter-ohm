; See: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#indents

; indent.begin       ; indent children when matching this node
; ------------

[
  ; <..., ...>
  (formals)
  (params)

  ; (...| ...)
  (alt)
] @indent.begin

(ERROR
  "|" @indent.begin
  (#set! indent.start_at_same_line))

; indent.branch      ; dedent itself when matching this node
; -------------

[
  "}"
  ")"
  ">"
] @indent.branch

; indent.end         ; marks the end of indented block
; ----------

[
  "}"
  ")"
  ">"
] @indent.end

; indent.auto        ; behaves like 'autoindent' buffer option
; -----------

[
  (singleline_comment)
  (multiline_comment)
  (ERROR)
] @indent.auto

; indent.align       ; behaves like python aligned/hanging indent
; ------------

; ; | ... | ...
(rule_body
  . (top_level_term) @indent.align
  (#set! indent.open_delimiter "|"))

; N/A or unused:
; --------------
; indent.dedent      ; dedent children when matching this node
; indent.ignore      ; do not indent in this node
; indent.zero        ; sets this node at position 0 (no indent)