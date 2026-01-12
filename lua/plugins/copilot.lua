return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<C-l>', require('copilot.suggestion').accept_line, desc = 'Accept [L]ine' },
    { '<C-j>', require('copilot.suggestion').accept,      desc = 'Accept suggestion' },
  },
  init = function()
    vim.g.copilot_no_tab_map = true
  end,
  config = function()
    require('copilot').setup {}
  end,
}
