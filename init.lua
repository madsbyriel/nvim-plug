local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- missing blink
-- missing typescript-tools

Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })

Plug('nvim-treesitter/nvim-treesitter')

Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')

Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')

-- for snippets
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

Plug('seblyng/roslyn.nvim')
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')

Plug('MunifTanjim/nui.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-neo-tree/neo-tree.nvim', {['tag'] = 'v3.x'})

Plug('ThePrimeagen/harpoon', {['tag'] = 'harpoon2'})

Plug('nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'make'})
Plug('nvim-telescope/telescope.nvim')

vim.call('plug#end')


vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.opt.termguicolors = true
vim.o.background = 'dark'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

-- Now doesn't add a newline when opening buffers
vim.opt.fixeol = false

-- Show a marker indicating errors at the column
vim.opt.signcolumn = 'yes'

-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_banner = 0

require("config.init")
