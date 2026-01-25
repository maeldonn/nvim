return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  build = ':Copilot auth',
  event = 'InsertEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    panel = { enabled = false },
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = '<C-j>',
        accept_line = '<C-l>',
      },
    },
  },
}
