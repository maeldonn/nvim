vim.pack.add { 'https://github.com/ray-x/go.nvim' }

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name ~= 'go.nvim' then
      return
    end

    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then
      return
    end

    require('go.install').update_all_sync()
  end,
})

require('go').setup()
