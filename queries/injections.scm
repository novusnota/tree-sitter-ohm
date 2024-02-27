; See: https://tree-sitter.github.io/tree-sitter/syntax-highlighting#language-injection

((singleline_comment) @injection.content
 (#set! injection.language "comment"))

((multiline_comment) @injection.content
 (#set! injection.language "comment"))
