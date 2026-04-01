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
    'https://github.com/windwp/nvim-autopairs',
    'https://github.com/akinsho/toggleterm.nvim',
    'https://github.com/akinsho/bufferline.nvim',
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
require 'plugins.bufferline'

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
require("toggleterm").setup {
    size = 25,
    open_mapping = [[<c-i>]],
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved'
        winblend = 0,
        highlights = {
            border = "FloatBorder",
            background = "Normal",
        }
    }
}

vim.g.VM_silent_exit = 1
vim.g.VM_show_warnings = 0
