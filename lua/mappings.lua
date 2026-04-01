vim.keymap.set({ 'n', 'v' }, '<C-l>', '$', { desc = 'Go to end of line' })
vim.keymap.set({ 'n', 'v' }, '<C-h>', '^', { desc = 'Go to end of line' })
vim.keymap.set('n', '<C-/>', '/<CR>', { desc = 'Search next occurence' })
vim.keymap.set('n', '<C-e>', ':Oil<CR>', { desc = 'Open file explorer' })
vim.keymap.set('n', '<leader>l',
    function()
        vim.lsp.buf.format { async = true }
    end,
    { desc = 'Format current buffer via LSP' }
)
