; NOTE: Following queries are NOT used for highlighting, unlike in Tree-sitter or Helix.
; NOTE: These are more like tags.scm, but specifically for Neovim.
; See: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#locals
; ------------------------------------------------------------------------------------------

; Scopes       @local.scope
; -------------------------

(grammar_body) @local.scope

; Definitions  @local.definition
; ------------------------------

; methods

(rule
  name: (identifier) @local.definition.method)

; parameters

(formals
  (identifier) @local.definition.parameter)

; References   @local.reference
; -----------------------------

(term
  base: (identifier) @local.reference)
