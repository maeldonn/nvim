vim.pack.add { 'https://github.com/folke/snacks.nvim' }

require('snacks').setup {
  bigfile = {},
  picker = {},
  explorer = { replace_netrw = true, trash = true },
  input = {},
  quickfile = {},
  statuscolumn = {},
}

-- Explore
vim.keymap.set('n', '\\', function()
  local explorer_win = nil

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype
    if ft == 'snacks_picker_list' then
      explorer_win = win
      break
    end
  end

  if vim.api.nvim_get_current_win() ~= explorer_win and explorer_win then
    vim.api.nvim_set_current_win(explorer_win)
  else
    require('snacks').explorer()
  end
end, { desc = 'File Explorer' })

-- Pickers
local picker = require 'snacks.picker'

vim.keymap.set('n', '<leader>sf', function()
  picker.files {
    layout = 'select',
    hidden = true,
    exclude = {
      '**/node_modules/*',
      '**/vendor/*',
      '**/gen/*',
    },
  }
end, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>sF', function()
  picker.git_files { layout = 'select' }
end, { desc = '[C-p] Search git files' })

vim.keymap.set({ 'n', 'x', 'v' }, '<leader>sw', function()
  picker.grep_word {
    focus = 'list',
    hidden = true,
    exclude = {
      '**/node_modules/*',
      '**/vendor/*',
      '**/gen/*',
    },
  }
end, { desc = '[S]earch current [W]ord' })

vim.keymap.set('n', '<leader>sg', function()
  picker.grep {
    hidden = true,
    exclude = {
      '**/node_modules/*',
      '**/vendor/*',
      '**/gen/*',
    },
  }
end, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>sd', function()
  picker.diagnostics { focus = 'list' }
end, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>sr', function()
  picker.resume { focus = 'list' }
end, { desc = '[S]earch [R]esume' })

vim.keymap.set('n', '<leader>gs', function()
  picker.git_status { focus = 'list' }
end, { desc = '[G]it [S]tatus' })

vim.keymap.set('n', '<leader><leader>', function()
  picker.buffers { layout = 'select', focus = 'list' }
end, { desc = '[ ] Find existing buffers' })
