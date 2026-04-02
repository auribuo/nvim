local M = {}
local palette = require('palette')

function M.setup()
    local bufferline = require('bufferline')
    bufferline.setup {
        options = {
            mode = "buffers",
            themable = true,
            indicator = {
                style = 'none'
            },
            separator_style = { "", "" },
            always_show_bufferline = false,
            show_buffer_close_icons = false,
            show_close_icon = false,
            color_icons = true,
            diagnostics = 'nvim_lsp',
            diagnostics_indicator = function(count, level)
                local icon = level:match("error") and "!" or "*"
                return " " .. icon .. count
            end
        },
        highlights = palette.bufferline_theme()
    }
end

return M
