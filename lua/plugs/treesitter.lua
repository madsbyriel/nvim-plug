require('nvim-treesitter').install({
    'lua', 'vim', 'vimdoc', 'bash',
    'rust', 'zig', 'python', 'c_sharp', 'go',
    'markdown', 'markdown_inline', 'json', 'yaml', 'toml',
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        if vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf, lang)
        end
    end,
})
