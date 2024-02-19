# tree-sitter-ohm
🌳 Tree-sitter grammar for the Ohm domain-specific language. Quickly build parsers, interpreters, and compilers for programming languages with Ohm's parsing toolkit!

## 🎨 Structure

Grammar definition resides in `grammar.js`:

- Actual grammar and bindings are generated from it via Tree-sitter.
- Queries and tests rely on its namings of nodes and fields.

Generic queries are structured as follows:

```
queries/
|-- highlights.scm -- syntax highlighting queries (generic, for Tree-sitter & GitHub)
|-- injections.scm -- specification for embedded syntaxes (mainly used for TODO/FIXME highlighting in comments)
`-- tags.scm -- tagging queries for code navigation systems (as used on GitHub)
```

To find highlighting and other queries for specific editors, look in the `editor_queries/` directory.

## 💲 CLI Usage

Tree-sitter grammars have limited utility on their own and are best used as parsers that can be embedded in other projects. However, [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) can be used with this grammar to show generated parse trees and syntax highlighting for a given ohm file.

For a quick demo of tree-sitter-cli usage:
1. Clone this repo.
2. Install Node.js dependencies (by `npm i`, `pnpm i` or `yarn`).
3. Execute relevant commands from the `scripts` tag in `package.json`.

For a more streamlined experience, you may:
1. [Install tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md#installation).
2. Create a `tree-sitters` directory in your home directory.
3. Clone this repository (or symlink it) into the new `~/tree-sitters/` directory.
4. Run `tree-sitter parse path/to/file.ohm` to be shown the parse tree for the file.
5. Run `tree-sitter highlight path/to/file.ohm` to be shown the file with syntax highlighting applied.

## ⚙ References

- [ohm-grammar.ohm](https://github.com/ohmjs/ohm/blob/main/packages/ohm-js/src/ohm-grammar.ohm) — Official grammar specification of Ohm PEG language, written itself in Ohm!

## Useful Ohm links

- [Official Website](https://ohmjs.org/)
- [GitHub.com Source](https://github.com/ohmjs/ohm)

## Credits

Examples in `test/sample` directory are taken from [ohmjs/ohm](https://github.com/ohmjs/ohm) under MIT license.

Built with 🤍 by [Novus Nota](https://github.com/novusnota)

## License

[MIT](LICENSE)
