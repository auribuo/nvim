local mappings = require("mappings")

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'make',
    callback = function()
        vim.opt_local.expandtab = false
    end
})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank() end
})
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = mappings.lsp_keymap,
})
