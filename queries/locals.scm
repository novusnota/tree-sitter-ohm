; See: https://tree-sitter.github.io/tree-sitter/syntax-highlighting#local-variables

; Scopes       @local.scope
; -------------------------

(grammar_body) @local.scope

; Definitions  @local.definition
; ------------------------------

(rule
  name: (identifier) @local.definition)

; References   @local.reference
; -----------------------------

(term
  base: (identifier) @local.reference)

; (formals
;   (identifier)* @local.reference)

; (identifier) @local.reference
