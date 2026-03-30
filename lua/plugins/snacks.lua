return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {},
    picker = {},
    explorer = { replace_netrw = true, trash = true },
    input = {},
    quickfile = {},
    statuscolumn = {},
  },
  keys = {
    -- Explore
    {
      '\\',
      function()
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
      end,
      desc = 'File Explorer',
    },
    -- Pickers
    {
      '<leader>sf',
      function()
        require('snacks.picker').files {
          layout = 'select',
          hidden = true,
          exclude = {
            '**/node_modules/*',
            '**/vendor/*',
            '**/gen/*',
          },
        }
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sF',
      function()
        require('snacks.picker').git_files { layout = 'select' }
      end,
      desc = '[C-p] Search git files',
    },
    {
      '<leader>sw',
      function()
        require('snacks.picker').grep_word {
          hidden = true,
          exclude = {
            '**/node_modules/*',
            '**/vendor/*',
            '**/gen/*',
          },
        }
      end,
      mode = { 'n', 'v', 'x' },
      desc = '[S]earch current [W]ord',
    },
    {
      '<leader>sg',
      function()
        require('snacks.picker').grep {
          hidden = true,
          exclude = {
            '**/node_modules/*',
            '**/vendor/*',
            '**/gen/*',
          },
        }
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sd',
      function()
        require('snacks.picker').diagnostics { focus = 'list' }
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>sr',
      function()
        require('snacks.picker').resume()
      end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>gs',
      function()
        require('snacks.picker').git_status { focus = 'list' }
      end,
      desc = '[G]it [S]tatus',
    },
    {
      '<leader><leader>',
      function()
        require('snacks.picker').buffers { layout = 'select', focus = 'list' }
      end,
      desc = '[ ] Find existing buffers',
    },
  },
}
