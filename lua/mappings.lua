local M = {}

local map = vim.keymap.set
local function cmd(c) return function() vim.cmd(c) end end

function M.setup()
    -- Movement extras
    map({ 'n', 'v' }, '<C-l>', '$', { desc = 'Go to end of line' })
    map({ 'n', 'v' }, '<C-h>', '^', { desc = 'Go to end of line' })

    -- Edits
    map('n', '<A-up>', '"zddk"zP', { desc = 'Move line up' })
    map('n', '<A-down>', '"zdd"zp', { desc = 'Move line down' })
    map('n', 'U', cmd("Undotree"), { desc = "Undotree show" })

    -- Find and explore
    local fzf = require('fzf-lua')
    map('n', '<ESC>', cmd('noh'), { desc = 'Clear search selections' })
    map('n', '<C-e>', cmd('Oil'), { desc = 'Open file explorer' })
    map('n', '<leader>fa', function() fzf.files({ cmd = "find . -type f" }) end, { desc = "FZF All files" })
    map('n', '<leader>fs', fzf.lsp_live_workspace_symbols, { desc = "FZF LSP Symbols" })
    map('n', '<leader>fw', fzf.git_files, { desc = "FZF Git files" })
    map('n', '<leader>fl', fzf.live_grep, { desc = "FZF Live Grep Workspace" })
    map('n', '<leader>fT', function()
        fzf.grep({
            search = "TODO:",
            rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
            prompt = 'Todos> '
        })
    end, { desc = "FZF Search TODOs" })

    -- Buffer navigation
    map("n", "<Tab>", cmd("BufferLineCycleNext"), { desc = "Next Buffer" })
    map("n", "<S-Tab>", cmd("BufferLineCyclePrev"), { desc = "Previous Buffer" })
    map("n", "<leader>x", cmd("bp|bd #"), { desc = "Close Buffer" })

    -- Basic LSP remaps
    map('n', '<C-/>', 'gcc', { remap = true, desc = "Comment line" })
    map('v', '<C-/>', 'gc', { remap = true, desc = "Comment selection" })

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
    local wks = require('which-key').show
    map("n", "<leader>?", function() wks({ global = false }) end, { desc = "Buffer Local Keymaps" })
    map("n", "<leader>/", function() wks() end, { desc = "All Keymaps" })

    -- Dev utils
    map("n", "<leader>tr", cmd("ReloadTheme"), { desc = "DEV Reload color scheme" })
end

function M.lsp_keymap(ev)
    local diag = vim.diagnostic
    local lspbuf = vim.lsp.buf

    -- Go to definition/etc.
    map('n', 'gd', lspbuf.definition, { buffer = ev.buf, desc = "LSP Go to Definition" })
    map('n', 'gi', lspbuf.implementation, { buffer = ev.buf, desc = "LSP Go to Implementation" })

    -- Diagnostics
    map('n', ']d', function() diag.jump({ count = 1 }) end, { buffer = ev.buf, desc = "Go to next diagnostic" })
    map('n', ']d', function() diag.jump({ count = -1 }) end, { buffer = ev.buf, desc = "Go to previous diagnostic" })
    map('n', '<leader>d', diag.open_float, { desc = "Show line diagnostics" })
    map('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
    -- Refactoring
    map({ 'n', 'v' }, '<leader>ca', lspbuf.code_action, { buffer = ev.buf, desc = "LSP Code Actions" })
    map('n', '<leader>ra', lspbuf.rename, { buffer = ev.buf, desc = "LSP Rename variable" })
    map('n', '<leader>l', function() lspbuf.format { async = true } end, { desc = 'Format current buffer via LSP' })
end

return M
