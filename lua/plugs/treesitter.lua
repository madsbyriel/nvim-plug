require'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "rust", "zig", "python", "c_sharp", "go" }, -- Auto-install C# parser
    auto_install = true,
    highlight = {
        enable = true,

        -- default highlighting is better than these
        disable = {
            "csv",
            "gitcommit"
        }
    },
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cs' },
    callback = function() vim.treesitter.start() end,
})
