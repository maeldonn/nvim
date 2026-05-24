vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }

local gitsigns = require("gitsigns")

gitsigns.setup {
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 600,
		ignore_whitespace = true,
	},
}

vim.keymap.set('n', '<leader>gh', function()
	gitsigns.preview_hunk_inline()
end, { desc = '[G]it preview [H]unk' })

vim.keymap.set('n', ']c', function()
	gitsigns.nav_hunk 'next'
end, { desc = 'Git navigate to next hunk' })

vim.keymap.set('n', '[c', function()
	gitsigns.nav_hunk 'prev'
end, { desc = 'Git navigate to previous hunk' })
