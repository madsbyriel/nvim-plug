-- plugins
require("plugs.telescope")
require("plugs.lualine")
require("plugs.neo-tree")
require("plugs.mason")
require("plugs.nvimcmp")
-- require("plugs.treesitter")
require("plugs.harpoon")
require("plugs.catppuccin")


-- Set some lsp functionality. Telescope is goated
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>lua require("telescope.builtin").git_branches()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lk", '<cmd>lua require("telescope.builtin").lsp_references()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>le', '<cmd>lua require("telescope.builtin").diagnostics()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ls', '<cmd>lua require("telescope.builtin").git_status()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>li', '<cmd>lua require("telescope.builtin").lsp_implementations()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>es', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ek', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ej', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })


-- Quick fix list
vim.api.nvim_set_keymap('n', '<leader>qj', '<cmd>cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>qk', '<cmd>cprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>qo', '<cmd>Telescope quickfix<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>qi", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local entry = {
    filename = vim.api.nvim_buf_get_name(0),
    lnum = pos[1],
    col = pos[2] + 1, -- Vim columns are 1-based
    text = "Manual mark"
  }
  vim.fn.setqflist({ entry }, 'a')  -- 'a' = append
  print("Added to quickfix list")
end)

vim.keymap.set("n", "<leader>qc", function()
    vim.fn.setqflist({}, 'r')
end)


-- For fun, see all colorschemes
vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>lua require("telescope.builtin").colorscheme()<CR>', { noremap = true, silent = true })

-- Create a new tab from current buffer (think buffer copy)
vim.api.nvim_set_keymap('n', '<leader>bc', '<cmd>tabnew %<CR>', { noremap = true, silent = true })

-- Create a new tab (think buffer new)
vim.api.nvim_set_keymap('n', '<leader>bn', '<cmd>tabnew<CR>', { noremap = true, silent = true })
