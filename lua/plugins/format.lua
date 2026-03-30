vim.pack.add {
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/NMAC427/guess-indent.nvim',
}

require('guess-indent').setup {}

local conform = require 'conform'
conform.setup {
  format_on_save = function(bufnr)
    local allowed_filetypes = { go = true, lua = true }
    local ft = vim.bo[bufnr].filetype

    if not allowed_filetypes[ft] then
      return
    end

    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    return { timeout_ms = 500, lsp_format = 'fallback' }
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    go = { 'goimports', 'gci', 'gofmt' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    md = { 'prettier' },
    json = { 'prettier' },
  },
}

vim.keymap.set('n', '<leader>f', function()
  conform.format { lsp_fallback = true, async = false, timeout_ms = 1000 }
end, { desc = '[F]ormat buffer or selection' })
