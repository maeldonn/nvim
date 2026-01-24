return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install {
      'vim',
      'lua',
      'bash',
      'go',
      'gomod',
      'gosum',
      'sql',
      'dockerfile',
      'yaml',
      'json',
      'markdown',
      'javascript',
      'typescript',
      'jsdoc',
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end

        -- Start only if a parser can actually be created for this buffer/lang
        local ok = pcall(vim.treesitter.get_parser, args.buf, lang)
        if not ok then
          return
        end

        pcall(vim.treesitter.start, args.buf, lang)
      end,
    })
  end,
}
