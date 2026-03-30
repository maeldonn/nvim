vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
}

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name ~= 'nvim-treesitter' then
      return
    end

    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then
      return
    end

    if not ev.data.active then
      vim.cmd.packadd 'nvim-treesitter'
    end

    vim.cmd [[TSUpdate]]
  end,
})

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
