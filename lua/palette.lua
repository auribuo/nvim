local M = {}
local caelestia_path = '/home/aurelio/.local/state/caelestia/scheme.json'
local f = io.open(caelestia_path, "r")
if not f then error("Failed to open file: " .. caelestia_path) end
local content = f:read("*a")
f:close()
local ok, data = pcall(vim.fn.json_decode, content)
if not ok or not data then
    error("Failed to deserialize scheme")
end
local c = data.colours
for key, value in pairs(c) do
    c[key] = '#' .. value
end

local hl = vim.api.nvim_set_hl

function M.nvim_theme()
    -- Reset highlights
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
    vim.g.colors_name = "caelestia"

    -- Core UI Highlights
    hl(0, "Normal", { fg = c.onBackground, bg = nil })
    hl(0, "NormalFloat", { fg = c.onSurface, bg = c.surfaceContainerLow })
    hl(0, "FloatBorder", { fg = c.outline, bg = c.surfaceContainerLow })
    hl(0, "ColorColumn", { bg = c.surfaceContainer })
    hl(0, "CursorLine", { bg = c.surfaceContainer })
    hl(0, "CursorLineNr", { fg = c.primary, bold = true })
    hl(0, "LineNr", { fg = c.overlay1 })
    hl(0, "Visual", { bg = c.primaryContainer })
    hl(0, "Search", { fg = c.onPrimary, bg = c.primary })
    hl(0, "IncSearch", { fg = c.onPrimary, bg = c.tertiary })
    hl(0, "Pmenu", { fg = c.onSurfaceVariant, bg = c.surfaceContainer })
    hl(0, "PmenuSel", { fg = c.onPrimary, bg = c.primary })
    hl(0, "VertSplit", { fg = c.surfaceContainerHigh })
    hl(0, "WinSeparator", { fg = c.surfaceContainerHigh })
    hl(0, "StatusLine", { guibg = nil })

    -- Syntax Highlighting
    hl(0, "Comment", { fg = c.subtext0, italic = true })
    hl(0, "Constant", { fg = c.peach })
    hl(0, "String", { fg = c.green })
    hl(0, "Character", { fg = c.green })
    hl(0, "Number", { fg = c.peach })
    hl(0, "Boolean", { fg = c.tertiary })
    hl(0, "Float", { fg = c.peach })

    hl(0, "Identifier", { fg = c.blue })
    hl(0, "Function", { fg = c.blue })
    hl(0, "Statement", { fg = c.mauve })
    hl(0, "Conditional", { fg = c.mauve })
    hl(0, "Repeat", { fg = c.mauve })
    hl(0, "Label", { fg = c.teal })
    hl(0, "Operator", { fg = c.onSurfaceVariant })
    hl(0, "Keyword", { fg = c.primary })
    hl(0, "Exception", { fg = c.mauve })

    hl(0, "PreProc", { fg = c.teal })
    hl(0, "Type", { fg = c.yellow })
    hl(0, "Special", { fg = c.sky })
    hl(0, "Underlined", { underline = true })
    hl(0, "Error", { fg = c.error })
    hl(0, "Todo", { fg = c.background, bg = c.tertiary, bold = true })

    -- Treesitter (@syntax)
    hl(0, "@variable", { fg = c.text })
    hl(0, "@variable.builtin", { fg = c.mauve })
    hl(0, "@variable.member", { fg = c.error })
    hl(0, "@keyword", { fg = c.mauve })
    hl(0, "@function.builtin", { fg = c.blue })
    hl(0, "@property", { fg = c.error })
    hl(0, "@type.builtin", { fg = c.yellow })
    hl(0, "@constructor", { fg = c.teal })
    hl(0, "@type", { fg = c.onSuccessContainer })

    -- LSP Diagnostics
    hl(0, "DiagnosticError", { fg = c.error })
    hl(0, "DiagnosticWarn", { fg = c.tertiary })
    hl(0, "DiagnosticInfo", { fg = c.blue })
    hl(0, "DiagnosticHint", { fg = c.teal })
    hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.error })
end

function M.lualine_theme()
    return {
        normal = {
            a = { bg = c.primary, fg = c.onPrimary, gui = 'bold' },
            b = { bg = c.surfaceContainer, fg = c.onSurface },
            c = { bg = nil, fg = c.onSurfaceVariant },
        },
        insert = { a = { bg = c.green, fg = c.background, gui = 'bold' } },
        visual = { a = { bg = c.mauve, fg = c.background, gui = 'bold' } },
        replace = { a = { bg = c.error, fg = c.background, gui = 'bold' } },
        inactive = {
            a = { bg = c.background, fg = c.subtext0 },
            b = { bg = c.background, fg = c.subtext0 },
            c = { bg = c.background, fg = c.subtext0 },
        }
    }
end

function M.bufferline_theme()
    return {
        fill = { bg = c.background },
        background = { bg = c.background },

        buffer_selected = {
            fg = c.primary,
            bg = c.surfaceContainer,
            bold = true,
            italic = false,
        },
        indicator_selected = {
            fg = c.primary,
            bg = c.surfaceContainer,
        },
    }
end

return M
