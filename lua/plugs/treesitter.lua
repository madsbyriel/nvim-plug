require'nvim-treesitter.configs'.setup {
    ensure_installed = { 'c_sharp' }, -- Auto-install C# parser
    highlight = {
        enable = true,
    },
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cs' },
    callback = function() vim.treesitter.start() end,
})
