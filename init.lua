vim.g.mapleader = ' '

require('palette').nvim_theme()

-- OPTIONS
require 'options'

-- PLUGINS
require 'plugins'

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
