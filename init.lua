vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- OPTIONS
require 'options'

local palette = require('palette')

palette.nvim_theme()
vim.api.nvim_create_user_command("ReloadTheme", function()
    package.loaded["palette"] = nil
    palette = require("palette")
    palette.register_cb(require("plugins.lualine").setup)
    palette.register_cb(require("plugins.bufferline").setup)
    palette.nvim_theme()
end, {})

-- PLUGINS
require 'plugins'
palette.register_cb(require("plugins.lualine").setup)
palette.register_cb(require("plugins.bufferline").setup)

-- AUTOCMDS
require 'autocmds'

-- KEYMAPS
require('mappings').setup()

-- MISC
vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    virtual_text = {
        spacing = 4,
        prefix = '●',
        severity_limit = vim.diagnostic.severity.HINT,
    },
    float = { border = "rounded", source = "if_many", },
    -- jump = { float = true } -- TODO: Find replacement
})
