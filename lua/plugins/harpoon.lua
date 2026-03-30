vim.pack.add { 'https://github.com/ThePrimeagen/harpoon' }

local ui = require 'harpoon.ui'

vim.keymap.set('n', '<leader>a', function()
  require('harpoon.mark').add_file()
end, { desc = '[A]dd file to Harpoon' })

vim.keymap.set('n', '<C-e>', function()
  ui.toggle_quick_menu()
end, { desc = '[E]dit files in Harpoon' })

vim.keymap.set('n', '<C-h>', function()
  ui.nav_file(1)
end, { desc = '[C-h] Go to first harpoon file' })

vim.keymap.set('n', '<C-j>', function()
  ui.nav_file(2)
end, { desc = '[C-j] Go to second harpoon file' })

vim.keymap.set('n', '<C-k>', function()
  ui.nav_file(3)
end, { desc = '[C-k] Go to third harpoon file' })

vim.keymap.set('n', '<C-l>', function()
  ui.nav_file(4)
end, { desc = '[C-l] Go to fourth harpoon file' })
