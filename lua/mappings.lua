local map = vim.keymap.set

map({ 'n', 'v' }, '<C-l>', '$', { desc = 'Go to end of line' })
map({ 'n', 'v' }, '<C-h>', '^', { desc = 'Go to end of line' })
map('n', '<C-/>', '/<CR>', { desc = 'Search next occurence' })
map('n', '<C-e>', ':Oil<CR>', { desc = 'Open file explorer' })
map('n', '<leader>l',
    function()
        vim.lsp.buf.format { async = true }
    end,
    { desc = 'Format current buffer via LSP' }
)
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })
map("n", "<leader>x", "<cmd>bp|bd #<cr>", { desc = "Close Buffer" })
