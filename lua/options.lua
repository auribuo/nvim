vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorlineopt = 'both'
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.confirm = true
vim.o.signcolumn = 'yes:1'
vim.o.termguicolors = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldcolumn = '1'
vim.o.fillchars = "foldopen:,foldclose:,fold: ,foldsep: ,foldinner: "

vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = '●',
        severity_limit = vim.diagnostic.severity.HINT,
    },
    update_in_insert = true,
    float = {
        border = "rounded",
        source = "if_many",
    },
})
