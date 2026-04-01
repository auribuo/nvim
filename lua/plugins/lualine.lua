local M = {}

local palette = require('palette')

local function pos()
    return '[%l/%L:%c]'
end

function M.setup()
    require('lualine').setup {
        options = { theme = palette.lualine_theme() },
        -- tabline = {
        --     lualine_a = { 'buffers' },
        --     lualine_z = { 'tabs' }
        -- },
        sections = {
            lualine_b = { '%y', 'filename' },
            lualine_c = { 'branch' },
            lualine_x = {},
            lualine_y = { 'lsp_status', 'diagnostics' },
            lualine_z = { pos, 'progress' }
        },
        extensions = { 'oil' }
    }
end

palette.register_cb(M.setup)

return M
