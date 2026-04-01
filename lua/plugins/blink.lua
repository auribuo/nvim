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
