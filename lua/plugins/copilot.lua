vim.pack.add {
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/nvim-lua/plenary.nvim',
}

require('copilot').setup {
  panel = { enabled = false },
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = '<C-j>',
      accept_line = '<C-l>',
    },
  },
}
