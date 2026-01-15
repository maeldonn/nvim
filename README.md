# Maël's Neovim Config

Opinionated Neovim setup optimized for Go, Node, and Lua, with fast navigation. Uses lazy-loading for snappy startup and a curated plugin set for LSP, treesitter, search, Git, and file navigation.

## Requirements
- `neovim` ≥ 0.11
- Nerd Font installed (for icons)
- Tree-sitter parsers: run `:TSUpdate`
- Optional (Go): `go` ≥ 1.20 for `gopls`
- ripgrep binary for telescope
- tree-sitter-cli binary

## Install
- Place the config at `~/.config/nvim`
- Start Neovim and run `:Lazy sync`
- After plugins install, run `:TSUpdate`

Structure:
- `init.lua` loads `config/*` and bootstraps `lazy.nvim`
- `lua/config/*` core: `options`, `keymaps`, `autocmds`, `lazy`
- `lua/plugins/*` plugin specs (managed by lazy.nvim)
- `lsp/*` lsp settings

Enjoy a fast, pragmatic editing workflow tailored for Go, Node, and Lua.
