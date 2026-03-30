vim.pack.add {
  'https://github.com/catppuccin/nvim',
  'https://github.com/gruvbox-community/gruvbox',
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/rose-pine/neovim',
}

require('catppuccin').setup {
  flavour = 'macchiato',
}

vim.cmd.colorscheme 'catppuccin'
