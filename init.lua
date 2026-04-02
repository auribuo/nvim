vim.g.mapleader = ' '

local palette = require('palette')

palette.nvim_theme()
vim.api.nvim_create_user_command("ReloadTheme", function()
    package.loaded["palette"] = nil
    palette = require("palette")
    palette.register_cb(require("plugins.lualine").setup)
    palette.register_cb(require("plugins.bufferline").setup)
    palette.nvim_theme()
end, {})

-- OPTIONS
require 'options'

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
