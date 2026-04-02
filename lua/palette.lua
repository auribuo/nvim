local colors = require('colors')

local M = {
    callbacks = {}
}

local home = vim.fn.environ()['HOME']
if not home then return end
local caelestia_path = home .. '/.local/state/caelestia/scheme.json'

---@type CaelestiaSchemeColors
local c = {}
local is_dark = true

local function ifd(d, l)
    if is_dark then return d else return l end
end

---@class HiglightOpts
---@field fg Color|nil
---@field bg Color|nil
---@field bold boolean|nil
---@field italic boolean|nil

---@param name string
---@param opts HiglightOpts
local function hl(name, opts)
    ---@param col Color|nil
    local function m(col)
        if not col then return nil end
        local rgb = col:to_rgb()
        if rgb:len() ~= 7 then error(rgb) end
        return rgb
    end
    vim.api.nvim_set_hl(0, name, {
        fg = m(opts.fg),
        bg = m(opts.bg),
        bold = opts.bold or false,
        italic = opts.italic or false,
    })
end

local function load_colors()
    local f = io.open(caelestia_path, "r")
    if not f then
        return
    end
    local content = f:read("*a")
    f:close()

    local ok, data = pcall(vim.fn.json_decode, content)
    if not ok or not data then
        return
    end

    is_dark = data.mode == "dark"
    c = data.colours
    for key, value in pairs(c) do
        if not value:find("^#") then
            local h, s, l = colors.rgb_string_to_hsl('#' .. value)
            c[key] = colors.new(h, s, l):desaturate_by(ifd(1.3, 1))
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
    hl("Normal", { fg = c.onBackground, bg = nil })
    hl("Delimiter", { fg = c.onBackground:lighten_by(0.8) })
    hl("NormalFloat", { fg = c.onSurface, bg = c.surfaceContainerLow })
    hl("FloatBorder", { fg = c.outline, bg = c.surfaceContainerLow })
    hl("ColorColumn", { bg = c.surfaceContainer })
    hl("CursorLine", { bg = c.surfaceContainer })
    hl("CursorLineNr", { fg = c.primary, bold = true })
    hl("LineNr", { fg = c.overlay1 })
    hl("Visual", { bg = c.primaryContainer })
    hl("Search", { fg = c.onPrimary, bg = c.primary })
    hl("IncSearch", { fg = c.onPrimary, bg = c.tertiary })
    hl("Pmenu", { fg = c.onSurfaceVariant, bg = c.surfaceContainer })
    hl("PmenuSel", { fg = c.onPrimary, bg = c.primary })
    hl("VertSplit", { fg = c.surfaceContainerHigh })
    hl("WinSeparator", { fg = c.surfaceContainerHigh })
    hl("StatusLine", { bg = nil })
    hl("StatusLineNC", { bg = nil })
    hl("Folded", { bg = nil, fg = c.subtext0, bold = true })

    -- Dirs
    hl("Directory", { fg = c.blue })

    -- Syntax Highlighting
    hl("Comment", { fg = c.subtext0, italic = true })
    hl("Constant", { fg = c.peach })
    hl("String", { fg = c.green })
    hl("Character", { fg = c.green })
    hl("Number", { fg = c.peach })
    hl("Boolean", { fg = c.tertiary })
    hl("Float", { fg = c.peach })
    hl("Identifier", { fg = c.blue })
    hl("Function", { fg = c.blue })
    hl("Statement", { fg = c.mauve })
    hl("Conditional", { fg = c.mauve })
    hl("Repeat", { fg = c.mauve })
    hl("Label", { fg = c.teal })
    hl("Operator", { fg = c.onSurfaceVariant })
    hl("Keyword", { fg = c.primary })
    hl("Exception", { fg = c.mauve })
    hl("PreProc", { fg = c.text, bold = true })
    hl("Type", { fg = c.yellow })
    hl("Special", { fg = c.primary:hue_offset(40):desaturate_by(0.9) })
    hl("Underlined", { underline = true })
    hl("Error", { fg = c.error })
    hl("Todo", { fg = c.background, bg = c.tertiary, bold = true })

    -- Treesitter
    hl("@variable", { fg = c.text })
    hl("@variable.builtin", { fg = c.peach })
    hl("@variable.member", { fg = c.error:desaturate_by(ifd(0.7, 0.3)) })
    hl("@variable.parameter", { fg = c.error:desaturate_by(0.7) })
    hl("@keyword", { fg = c.mauve })
    hl("@function.builtin", { fg = c.blue })
    hl("@property", { fg = c.error })
    hl("@type.builtin", { fg = c.yellow:lighten_by(ifd(1, 0.7)) })
    hl("@constructor", { fg = c.teal })
    hl("@type", {
        fg = c.primary:complementary()
            :desaturate_by(ifd(1.5, 2))
            :lighten_by(ifd(1, 0.7))
    })

    -- LSP Diagnostics
    hl("DiagnosticError", { fg = c.error })
    hl("DiagnosticWarn", { fg = c.tertiary })
    hl("DiagnosticInfo", { fg = c.blue })
    hl("DiagnosticHint", { fg = c.teal })
    hl("DiagnosticUnderlineError", { undercurl = true, sp = c.error })

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
            a = { bg = c.primary:lighten_by(0.9):to_rgb(), fg = c.onPrimary:to_rgb(), gui = 'bold' },
            b = { bg = c.surfaceContainer:to_rgb(), fg = c.onSurface:to_rgb() },
            c = { bg = nil, fg = c.onSurfaceVariant:to_rgb() },
        },
        insert = { a = { bg = c.green:to_rgb(), fg = c.background:to_rgb(), gui = 'bold' } },
        visual = { a = { bg = c.mauve:to_rgb(), fg = c.background:to_rgb(), gui = 'bold' } },
        replace = { a = { bg = c.error:to_rgb(), fg = c.background:to_rgb(), gui = 'bold' } },
        inactive = {
            a = { bg = c.background:to_rgb(), fg = c.subtext0:to_rgb() },
            b = { bg = c.background:to_rgb(), fg = c.subtext0:to_rgb() },
            c = { bg = c.background:to_rgb(), fg = c.subtext0:to_rgb() },
        }
    }
end

function M.bufferline_theme()
    return {
        fill = { bg = nil },
        background = { bg = nil },
        buffer_selected = {
            fg = c.primary:to_rgb(),
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

-- TYPES
--- @class CaelestiaSchemeColors
--- @field background Color|nil
--- @field onBackground Color|nil
--- @field surface Color|nil
--- @field surfaceDim Color|nil
--- @field surfaceBright Color|nil
--- @field surfaceContainerLowest Color|nil
--- @field surfaceContainerLow Color|nil
--- @field surfaceContainer Color|nil
--- @field surfaceContainerHigh Color|nil
--- @field surfaceContainerHighest Color|nil
--- @field onSurface Color|nil
--- @field surfaceVariant Color|nil
--- @field onSurfaceVariant Color|nil
--- @field inverseSurface Color|nil
--- @field inverseOnSurface Color|nil
--- @field outline Color|nil
--- @field outlineVariant Color|nil
--- @field shadow Color|nil
--- @field scrim Color|nil
--- @field surfaceTint Color|nil
--- @field primary Color|nil
--- @field onPrimary Color|nil
--- @field primaryContainer Color|nil
--- @field onPrimaryContainer Color|nil
--- @field inversePrimary Color|nil
--- @field secondary Color|nil
--- @field onSecondary Color|nil
--- @field secondaryContainer Color|nil
--- @field onSecondaryContainer Color|nil
--- @field tertiary Color|nil
--- @field onTertiary Color|nil
--- @field tertiaryContainer Color|nil
--- @field onTertiaryContainer Color|nil
--- @field error Color|nil
--- @field onError Color|nil
--- @field errorContainer Color|nil
--- @field onErrorContainer Color|nil
--- @field primaryFixed Color|nil
--- @field primaryFixedDim Color|nil
--- @field onPrimaryFixed Color|nil
--- @field onPrimaryFixedVariant Color|nil
--- @field secondaryFixed Color|nil
--- @field secondaryFixedDim Color|nil
--- @field onSecondaryFixed Color|nil
--- @field onSecondaryFixedVariant Color|nil
--- @field tertiaryFixed Color|nil
--- @field tertiaryFixedDim Color|nil
--- @field onTertiaryFixed Color|nil
--- @field onTertiaryFixedVariant Color|nil
--- @field term0 Color|nil
--- @field term1 Color|nil
--- @field term2 Color|nil
--- @field term3 Color|nil
--- @field term4 Color|nil
--- @field term5 Color|nil
--- @field term6 Color|nil
--- @field term7 Color|nil
--- @field term8 Color|nil
--- @field term9 Color|nil
--- @field term10 Color|nil
--- @field term11 Color|nil
--- @field term12 Color|nil
--- @field term13 Color|nil
--- @field term14 Color|nil
--- @field term15 Color|nil
--- @field rosewater Color|nil
--- @field flamingo Color|nil
--- @field pink Color|nil
--- @field mauve Color|nil
--- @field red Color|nil
--- @field maroon Color|nil
--- @field peach Color|nil
--- @field yellow Color|nil
--- @field green Color|nil
--- @field teal Color|nil
--- @field sky Color|nil
--- @field sapphire Color|nil
--- @field blue Color|nil
--- @field lavender Color|nil
--- @field text Color|nil
--- @field subtext1 Color|nil
--- @field subtext0 Color|nil
--- @field overlay2 Color|nil
--- @field overlay1 Color|nil
--- @field overlay0 Color|nil
--- @field surface2 Color|nil
--- @field surface1 Color|nil
--- @field surface0 Color|nil
--- @field base Color|nil
--- @field mantle Color|nil
--- @field crust Color|nil
--- @field success Color|nil
--- @field onSuccess Color|nil
--- @field successContainer Color|nil
--- @field onSuccessContainer Color|nil
