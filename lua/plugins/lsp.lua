return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
      { 'onsails/lspkind-nvim' },
    },
    opts = {
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
    },
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local function setup_keymaps(bufnr)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
        end

        map('n', 'K', '<cmd>Lspsaga hover_doc ++quiet<CR>', 'Hover documentation')
        map('n', 'gd', vim.lsp.buf.definition, '[G]o to [D]efinition')
        map('n', 'gD', vim.lsp.buf.declaration, '[G]o to [D]eclaration')
        map('n', 'gt', vim.lsp.buf.type_definition, '[G]o to [T]ype definition')
        map('n', 'gi', vim.lsp.buf.implementation, '[G]o to [I]mplementation')
        map('n', 'gu', '<cmd>Lspsaga finder<CR>', '[G]o to [U]sage')
        map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous diagnostic')
        map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic')
        map('n', 'gr', '<cmd>Lspsaga rename<CR>', 'Rename')
        map('i', '<C-h>', vim.lsp.buf.signature_help, 'Signature help')
        map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', '[C]ode [A]ction')
        map('n', '<leader>so', '<cmd>Lspsaga outline<CR>', '[S]ymbol [O]utline')
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
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      {
        'mason-org/mason.nvim',
        config = true,
      },
    },
    opts = {
      ensure_installed = {
        'lua_ls',
        'gopls',
        'vtsls',
      },
    },
  },
  {
    'glepnir/lspsaga.nvim',
    opts = {
      ui = { code_action = ' ' },
      lightbulb = { enable = false },
      symbol_in_winbar = { enable = false },
    },
  },
}
