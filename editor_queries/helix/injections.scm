; See: https://docs.helix-editor.com/guides/injection.html

((singleline_comment) @injection.content
 (#set! injection.language "comment")
 (#match? @injection.content "^//"))

((multiline_comment) @injection.content
 (#set! injection.language "comment")
 (#match? @injection.content "^//"))
