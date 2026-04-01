local palette = require('palette')

local bufferline = require('bufferline')
bufferline.setup {
    options = {
        style_preset = bufferline.style_preset.minimal,
        themable = true,
        mode = "buffers",         -- Show open buffers
        separator_style = "thin", -- or "slant" for a modern look
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        diagnostics = 'nvim_lsp',
    },
    -- highlights = palette.bufferline_theme()
}
