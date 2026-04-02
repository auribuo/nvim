local M = {}

local palette = require('palette')

local function pos()
    return '[%l/%L:%c]'
end

local function shortmode()
    local md = vim.api.nvim_get_mode()
    return md.mode:upper()
end


function M.setup()
    local win_width = vim.fn.winwidth(0)
    local function neg(v) return function() return not v() end end
    local function pick(c, t, f) if c() then return t else return f end end
    local function is_small_win()
        return win_width <= 127
    end

    require('lualine').setup {
        options = {
            theme = palette.lualine_theme(),
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                { 'mode', cond = neg(is_small_win), separator = { right = '' } },
                { shortmode, cond = is_small_win, separator = { right = '' } },
            },
            lualine_b = { '%y', 'filename' },
            lualine_c = { 'branch' },
            lualine_x = {},
            lualine_y = {
                { 'lsp_progress',
                    display_components =
                        pick(is_small_win,
                            { { 'message' } },
                            { 'lsp_client_name', { 'title', 'percentage' } }
                        )
                },
                'diagnostics',
                'lsp_status'
            },
            lualine_z = { { pos, separator = { left = '', right = '' } }, 'progress' }
        },
        extensions = { 'oil', 'toggleterm', 'fzf' }
    }
end

return M
