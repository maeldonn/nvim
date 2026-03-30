vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
}

require('mason').setup {}
require('mason-lspconfig').setup {
  ensure_installed = {
    'lua_ls',
    'gopls',
    'vtsls',
  },
}

local function setup_keymaps(bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
  end

  map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
  map('n', 'gr', vim.lsp.buf.rename, 'Rename')
  map('n', '[d', vim.diagnostic.get_prev, 'Previous diagnostic')
  map('n', '[d', vim.diagnostic.get_next, 'Next diagnostic')
  map('i', '<C-h>', vim.lsp.buf.signature_help, 'Signature help')
  map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  map('n', 'gd', function()
    require('snacks.picker').lsp_definitions { focus = 'list', layout = 'ivy' }
  end, '[G]o to [D]efinition')
  map('n', 'gD', function()
    require('snacks.picker').lsp_declarations { focus = 'list', layout = 'ivy' }
  end, '[G]o to [D]eclaration')
  map('n', 'gt', function()
    require('snacks.picker').lsp_type_definitions { focus = 'list', layout = 'ivy' }
  end, '[G]o to [T]ype definition')
  map('n', 'gi', function()
    require('snacks.picker').lsp_implementations { focus = 'list', layout = 'ivy' }
  end, '[G]o to [I]mplementation')
  map('n', 'gu', function()
    require('snacks.picker').lsp_references { focus = 'list', layout = 'ivy' }
  end, '[G]o to [U]sages (references)')
  map('n', '<leader>so', function()
    require('snacks.picker').lsp_symbols { focus = 'list', layout = 'right' }
  end, '[S]ymbol [O]utline')
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    setup_keymaps(bufnr)
  end,
})

vim.diagnostic.config {
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
}
