vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
  'https://github.com/leoluz/nvim-dap-go',
}

local dap = require 'dap'
local dapui = require 'dapui'
local dap_go = require 'dap-go'

dapui.setup()
dap_go.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open(1)
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

require('nvim-dap-virtual-text').setup {}

vim.keymap.set('n', '<Up>', function()
  dap.continue()
end, { desc = 'Continue debug' })

vim.keymap.set('n', '<Down>', function()
  dap.step_over()
end, { desc = 'Step over debug' })

vim.keymap.set('n', '<Right>', function()
  dap.step_into()
end, { desc = 'Step into debug' })

vim.keymap.set('n', '<Left>', function()
  dap.step_out()
end, { desc = 'Step out debug' })

vim.keymap.set('n', '<leader>b', function()
  dap.toggle_breakpoint()
end, { desc = 'Toggle breakpoint debug' })

vim.keymap.set('n', '<leader>B', function()
  require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Set conditional breakpoint debug' })

vim.keymap.set('n', '<leader>lp', function()
  require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
end, { desc = 'Set log point debug' })

vim.keymap.set('n', '<leader>dr', function()
  require('dap').repl.open()
end, { desc = 'Open DAP REPL' })

vim.keymap.set('n', '<leader>rc', function()
  require('dap').repl.run_to_cursor()
end, { desc = 'Run to cursor in DAP' })

vim.keymap.set('n', '<leader><Left>', function()
  require('dapui').toggle(1)
end, { desc = 'Toggle DAP UI 1' })

vim.keymap.set('n', '<leader><Down>', function()
  require('dapui').toggle(2)
end, { desc = 'Toggle DAP UI 2' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go' },
  callback = function()
    vim.keymap.set('n', '<leader>dt', function()
      dap_go.debug_test()
    end, { desc = '[D]ebug go [T]est', buffer = true })
  end,
})
