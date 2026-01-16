require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})

require("mason-lspconfig").setup {
    automatic_enable = true,
    ensure_installed = { "lua_ls", "rust_analyzer", "zls", "pyright", "gopls" }, -- Can't get roslyn to auto-install
}
