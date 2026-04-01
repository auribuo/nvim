vim.pack.add {
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/rktjmp/lush.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/saghen/blink.cmp',
    'https://github.com/nvim-mini/mini.icons',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/wakatime/vim-wakatime',
    'https://github.com/karb94/neoscroll.nvim',
    'https://github.com/mg979/vim-visual-multi',
    'https://github.com/windwp/nvim-autopairs'
}

require('nvim-treesitter').setup {
    install_dir = vim.fn.stdpath('data') .. '/site',
    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true }
}

require 'plugins.lsp'
require 'plugins.lualine'

require('blink.cmp').setup {
    cmdline = { enabled = true },
    appearance = { nerd_font_variant = "normal" },
    fuzzy = { implementation = "lua" },
    sources = { default = { "lsp", "buffer", "path" } },

    keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },

    completion = {
        -- ghost_text = { enabled = true },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = "single" },
        },
    },
}

require('oil').setup {}
require('neoscroll').setup {}
require('nvim-autopairs').setup {}

vim.g.VM_silent_exit = 1
vim.g.VM_show_warnings = 0
