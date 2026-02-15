return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {},
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
        require('snacks').explorer()
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
