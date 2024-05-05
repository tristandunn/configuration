# neovim

My neovim configuration.

## LSP

LSP is enabled with [neovim/nvim-lspconfig][] but requires the languages servers
to be manually installed.

### ESLint and JSON

The [eslint][] and [jsonls][] servers come from the
[vscode-langservers-extracted][] NPM library.

```
npm install --global vscode-langservers-extracted
```

### Lua

The [lua_ls][] comes from [lua-language-server][].

```
brew install lua-language-server
```

### Ruby

The [ruby_lsp][] comes from the [ruby-lsp][] library.

```
gem install ruby-lsp
```

### Stylelint

The [stylelint_lsp][] comes from the [stylelint-lsp][] library.

```
npm install --global stylelint-lsp
```

[eslint]: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
[jsonls]: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
[lua-language-server]: https://github.com/luals/lua-language-server
[lua_ls]: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
[neovim/nvim-lspconfig]: https://github.com/neovim/nvim-lspconfig
[ruby-lsp]: https://rubygems.org/gems/ruby-lsp
[ruby_lsp]: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruby_lsp
[stylelint-lsp]: https://github.com/bmatcuk/stylelint-lsp
[stylelint_lsp]: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#stylelint_lsp
[vscode-langservers-extracted]: https://github.com/hrsh7th/vscode-langservers-extracted
