local M = {
    callbacks = {}
}

local home = vim.fn.environ()['HOME']
if not home then
    error("HOME environment variable not set")
end
local caelestia_path = home .. '/.local/state/caelestia/scheme.json'

local hl = vim.api.nvim_set_hl
local c = {}

local function load_colors()
    local f = io.open(caelestia_path, "r")
    if not f then
        error("Could not open file: " .. caelestia_path)
        return
    end
    local content = f:read("*a")
    f:close()

    local ok, data = pcall(vim.fn.json_decode, content)
    if not ok or not data then
        error("Could not decode json file: " .. caelestia_path)
        return
    end

    c = data.colours
    for key, value in pairs(c) do
        if not value:find("^#") then
            c[key] = '#' .. value
        end
    end
end

function M.nvim_theme()
    load_colors()

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
    hl(0, "StatusLine", { bg = nil })
    hl(0, "StatusLineNC", { bg = nil })
    hl(0, "Folded", { bg = nil, fg = c.subtext0, bold = true })

    -- Dirs
    hl(0, "Directory", { fg = c.blue })

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

    -- Treesitter
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

    for _, cb in ipairs(M.callbacks) do
        cb()
    end
end

local function watch_file(path)
    local w = vim.loop.new_fs_event()
    if not w then
        vim.notify("Could not watch theme file", vim.log.levels.WARN)
        return
    end
    local on_change
    on_change = function()
        vim.schedule(function()
            M.nvim_theme()
            vim.notify("Caelestia theme reloaded", vim.log.levels.INFO)
        end)
        w:stop()
        w:start(path, {}, on_change)
    end
    w:start(path, {}, on_change)
end

watch_file(caelestia_path)

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
        fill = { bg = nil },
        background = { bg = nil },
        buffer_selected = {
            fg = c.primary,
            bg = nil,
            bold = true,
            italic = false,
        },
    }
end

function M.register_cb(cb)
    table.insert(M.callbacks, cb)
end

return M
