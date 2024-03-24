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
|-- locals.scm -- fixed set of capture names to track local scopes and variables (and alike)
|-- injections.scm -- specification for embedded syntaxes (mainly used for TODO/FIXME highlighting in comments)
`-- tags.scm -- tagging queries for code navigation systems (as used on GitHub)
```

To find highlighting and other queries for specific editors, look in the `editor_queries/` directory.

## 🚀 Usage

### Neovim

Installation assumes you're using [`lazy.nvim`](https://github.com/folke/lazy.nvim) as a plugin manager:

<details>
<summary>Instructions</summary>

1. Clone the repo to any convenient place: `git clone https://github.com/novusnota/tree-sitter-ohm ~/.local/git/tree-sitter-ohm` (`~/.local/git` is exemplary, you may choose another directory)

2. Add the following (partly or as a whole) to your `~/.config/nvim/init.lua` (Or `~\AppData\Local\nvim\init.lua` on Windows):

For the general Tree-sitter support:

```lua
-- lazy.nvim package manager
require('lazy').setup({
  -- ...
	{
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    -- Optional, may be removed:
    dependencies = {
      -- adds syntax aware text-objects, select, move, swap, and peek support
      -- see: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      'nvim-treesitter/nvim-treesitter-textobjects',

      -- adds a sticky context header on top as you scroll through file contents
      -- see: https://github.com/nvim-treesitter/nvim-treesitter-context
      'nvim-treesitter/nvim-treesitter-context'
    },
  },
  -- ...
}, {})
```

For the tree-sitter-ohm support:

```lua
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

-- Adds tree-sitter-ohm support
parser_config.ohm = {
  install_info = {
    url = "~/.local/git/tree-sitter-ohm", -- a path to the cloned repo
    files = {"src/parser.c", "src/scanner.c"},
    branch = "main",
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  }
}

-- Adds filetype recognition for .ohm files and simple indentation rules
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "*.ohm",
  callback = function()
    vim.bo.filetype = "ohm"
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
  end
})
```

3. Create a folder for queries under your Neovim runtime directory, if not exists:
  * Windows: `mkdir -p ~\AppData\Local\nvim\queries`
  * Linux, macOS, *NIX: `mkdir -p ~/.config/nvim/queries`

4. Symlink the `editor_queries/neovim` sub-directory, this will add all the queries:
  * Windows: `mklink /D ~\AppData\Local\nvim\queries\ohm ~\.local\git\tree-sitter-ohm\editor_queries\neovim`
  * Linux, macOS, *NIX: `ln -s ~/.local/git/tree-sitter-ohm/editor_queries/neovim ~/.config/nvim/queries/ohm`

5. Finally, run the `:TSInstall ohm` inside the Neovim.

6. For further configuration and customization, refer to the following repositories:
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
* [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)

</details>

Queries bundled (see `editor_queries/neovim`):
* `highlights.scm` — syntax highlighting
* `locals.scm` — used to extract keyword definitions, scopes, references, etc., but NOT used for highlighting (unlike Generic or Helix queries)
* `injections.scm` — highlighting of TODO, FIXME and related in single-line comments
* `folds.scm` — syntax folds (note, that folding has to be enabled in config in order to use those)
* `indents.scm` — indentation levels
* `textobjects.scm` — syntax aware text-objects, select, move, swap, and peek support.
* `context.scm` — shows sticky context on top of the editor as you scroll through file contents

### Helix

<details>
<summary>Instructions</summary>

1. Clone the repo to any convenient place: `git clone https://github.com/novusnota/tree-sitter-ohm ~/.local/git/tree-sitter-ohm` (`~/.local/git` is exemplary, you may choose another directory)

2. Create a folder for queries under your Helix runtime directory, if not exists:
  * Windows: `mkdir -p ~\AppData\Roaming\helix\runtime\queries`
  * Linux, macOS, *NIX: `mkdir -p ~/.config/helix/runtime/queries`

3. Symlink the `editor_queries/helix` sub-directory, this will add all the queries:
  * Windows: `mklink /D ~\AppData\Roaming\helix\runtime\queries\ohm ~\.local\git\tree-sitter-ohm\editor_queries\helix`
  * Linux, macOS, *NIX: `ln -s ~/.local/git/tree-sitter-ohm/editor_queries/helix ~/.config/helix/runtime/queries/ohm`

4. Add the following to your `~/.config/helix/languages.toml` (Or `~\AppData\Roaming\helix\languages.toml` on Windows):

```toml
[[language]]
name = "ohm"
scope = "source.ohm"
injection-regex = "ohm"
file-types = ["ohm"]
comment-token = "//"
indent = { tab-width = 2, unit = "  " }
roots = []

[language.auto-pairs]
'"' = '"'
'{' = '}'
'(' = ')'
'<' = '>'

[[grammar]]
name = "ohm"
source = { path = "/absolute/path/to/your/home/directory/.local/git/tree-sitter-ohm" }  # TODO: replace with your full path to downloaded repo
```

5. Finally, run the following commands to update all Tree-sitter grammars, including ohm's:

```bash
hx --grammar fetch
hx --grammar build
```

</details>

Queries bundled (see `editor_queries/helix`):
* `highlights.scm` — syntax highlighting
* `injections.scm` — highlighting of TODO, FIXME and related in single-line comments
* `indents.scm` — indentation levels
* `textobjects.scm` — syntax aware text-objects

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
- [Awesome Ohm list](https://github.com/ohmjs/awesome-ohm)
- [VSCode extension](https://github.com/novusnota/vscode-ohm)

## Credits

Examples in `test/sample` directory are taken from [ohmjs/ohm](https://github.com/ohmjs/ohm) under MIT license.

Built with 🤍 by [Novus Nota](https://github.com/novusnota)

## License

[MIT](LICENSE)