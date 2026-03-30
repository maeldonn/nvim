vim.pack.add {
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '*' },
  { src = 'https://github.com/L3MON4D3/LuaSnip' },
  { src = 'https://github.com/onsails/lspkind-nvim' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
}

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name ~= 'blink.cmp' then
      return
    end

    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then
      return
    end

    vim.system({ 'cargo', 'build', '--release' }, { cwd = ev.data.path })
  end,
})

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name ~= 'LuaSnip' then
      return
    end

    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then
      return
    end

    vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path })
  end,
})

require('luasnip').setup()
require('luasnip.loaders.from_vscode').lazy_load()

require('blink.cmp').setup {
  snippets = { preset = 'luasnip' },
  completion = {
    menu = {
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                if dev_icon then
                  icon = dev_icon
                end
              else
                icon = require('lspkind').symbolic(ctx.kind, {
                  mode = 'symbol',
                })
              end

              return icon .. ctx.icon_gap
            end,

            -- Optionally, use the highlight groups from nvim-web-devicons
            -- You can also add the same function for `kind.highlight` if you want to
            -- keep the highlight groups in sync with the icons.
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                if dev_icon then
                  hl = dev_hl
                end
              end
              return hl
            end,
          },
        },
      },
    },
  },
  keymap = {
    preset = 'enter',
  },
}
