vim.o.number = true
vim.o.relativenumber = true
vim.o.relativenumber = true

vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.breakindent = true

vim.o.signcolumn = 'yes:1'
vim.o.cursorlineopt = 'both'

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldcolumn = '1'
vim.o.fillchars = "foldopen:,foldclose:,fold: ,foldsep: ,foldinner: "

vim.o.undofile = true

vim.o.showmode = false
vim.o.confirm = true
vim.o.termguicolors = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.inccommand = 'split'
