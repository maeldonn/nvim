return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    explorer = { replace_netrw = true, trash = true },
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
  },
}
