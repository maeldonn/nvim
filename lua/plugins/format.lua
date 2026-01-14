return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { lsp_fallback = true, async = false, timeout_ms = 1000 }
        end,
        mode = '',
        desc = '[F]ormat buffer or selection',
      },
    },
    opts = {
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
        go = { 'goimports', 'gofmt' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        md = { 'prettier' },
        json = { 'prettier' },
      },
    },
  },
  {
    'NMAC427/guess-indent.nvim',
    config = true,
  },
}
