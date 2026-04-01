vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'make',
    callback = function()
        vim.opt_local.expandtab = false
    end
})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank() end
})
