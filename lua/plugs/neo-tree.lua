local tree = require('neo-tree.command')
vim.keymap.set("n", "<leader>t", function ()
	tree.execute({
		toggle = true
	})
end)
