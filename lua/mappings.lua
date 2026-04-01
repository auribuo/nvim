local map = vim.keymap.set

local M = {}

function M.setup()
    -- Movement extras
    map({ 'n', 'v' }, '<C-l>', '$', { desc = 'Go to end of line' })
    map({ 'n', 'v' }, '<C-h>', '^', { desc = 'Go to end of line' })

    -- Find and explore
    local fzf = require('fzf-lua')
    map('n', '<ESC>', function() vim.cmd("noh") end, { desc = 'Clear search selections' })
    map('n', '<C-e>', ':Oil<CR>', { desc = 'Open file explorer' })
    map('n', '<leader>fa', function() fzf.files({ cmd = "find . -type f" }) end, { desc = "FZF All files" })
    map('n', '<leader>fs', fzf.lsp_live_workspace_symbols, { desc = "FZF LSP Symbols" })
    map('n', '<leader>fw', fzf.git_files, { desc = "FZF Git files" })
    map('n', '<leader>fl', fzf.live_grep, { desc = "FZF Live Grep Workspace" })

    -- Buffer navigation
    map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
    map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })
    map("n", "<leader>x", "<cmd>bp|bd #<cr>", { desc = "Close Buffer" })

    -- Basic LSP remaps
    map('n', '<leader>/', 'gcc', { remap = true, desc = "Comment line" })
    map('v', '<leader>/', 'gc', { remap = true, desc = "Comment selection" })

    -- Navigate windows
    map('n', '<A-h>', '<C-w>h', { desc = 'Move to left window' })
    map('n', '<A-j>', '<C-w>j', { desc = 'Move to lower window' })
    map('n', '<A-k>', '<C-w>k', { desc = 'Move to upper window' })
    map('n', '<A-l>', '<C-w>l', { desc = 'Move to right window' })

    -- Folds
    map('n', '<leader>sj', 'za', { desc = 'Fold toggle under cursor' })
    map('n', '<leader>sa', 'zR', { desc = 'Fold open all' })
    map('n', '<leader>sA', 'zM', { desc = 'Fold close all' })
    map('n', '<leader>sf', 'zMzv', { desc = 'Fold focus under cursor' })
    map('n', '<leader>st', 'zi', { desc = 'Fold toggle on/off' })

    -- HELP ME
    map("n", "<leader>?", function() require("which-key").show({ global = false }) end, { desc = "Buffer Local Keymaps" })
    map("n", "<leader>/", function() require("which-key").show() end, { desc = "All Keymaps" })
end

function M.lsp_keymap(ev)
    -- Go to definition/etc.
    map('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "LSP Go to Definition" })
    map('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "LSP Go to Implementation" })

    -- Diagnostics
    map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
        { buffer = ev.buf, desc = "Go to next diagnostic" })
    map('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show line diagnostics" })

    -- Refactoring
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP Code Actions" })
    map('n', '<leader>ra', vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP Rename variable" })
    map('n', '<leader>l', function() vim.lsp.buf.format { async = true } end, { desc = 'Format current buffer via LSP' })
end

return M
