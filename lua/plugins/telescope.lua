return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  keys = {
    { '<leader>sf', require('telescope.builtin').find_files, desc = '[S]earch [F]iles' },
    { '<leader>sF', require('telescope.builtin').git_files, desc = '[C-p] Search git files' },
    { '<leader>sw', require('telescope.builtin').grep_string, desc = '[S]earch current [W]ord' },
    { '<leader>sg', require('telescope.builtin').live_grep, desc = '[S]earch by [G]rep' },
    { '<leader>sd', require('telescope.builtin').diagnostics, desc = '[S]earch [D]iagnostics' },
    { '<leader>sr', require('telescope.builtin').resume, desc = '[S]earch [R]esume' },
    { '<leader><leader>', require('telescope.builtin').buffers, desc = '[ ] Find existing buffers' },
  },
  config = function()
    local telescope = require 'telescope'

    telescope.setup {
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
          '--glob',
          '!**/.git/*',
          '--glob',
          '!**/node_modules/*',
          '--glob',
          '!**/vendor/*',
          '--glob',
          '!**/gen/*',
        },
      },
      pickers = {
        find_files = {
          theme = 'dropdown',
          previewer = false,
          find_command = {
            'rg',
            '--files',
            '--hidden',
            '--glob',
            '!**/.git/*',
            '--glob',
            '!**/node_modules/*',
            '--glob',
            '!**/vendor/*',
            '--glob',
            '!**/gen/*',
          },
        },
        git_files = {
          theme = 'dropdown',
          previewer = false,
        },
        grep_string = {
          initial_mode = 'normal',
        },
        diagnostics = {
          initial_mode = 'normal',
        },
        resume = {
          initial_mode = 'normal',
        },
        buffers = {
          initial_mode = 'normal',
          previewer = false,
          theme = 'dropdown',
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, 'fzf')
  end,
}
