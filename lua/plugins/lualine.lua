local palette = require('palette')

local function pos()
    return '[%l/%L:%c]'
end

local function get_active_lsp_names()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local client_names = {}

    for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
    end

    return table.concat(client_names, ', ')
end

require('lualine').setup {
    options = { theme = palette.lualine_theme() },
    sections = {
        lualine_b = { '%y', 'filename' },
        lualine_c = { },
        lualine_x = { },
        lualine_y = { get_active_lsp_names },
        lualine_z = { pos, 'progress' }
    }
}
