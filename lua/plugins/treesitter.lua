require('nvim-treesitter').setup {
    install_dir = vim.fn.stdpath('data') .. '/site',
    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true }
}
local ts_parsers = {}
for k, v in pairs(require('nvim-treesitter').get_installed()) do
    ts_parsers[k] = v
end
vim.api.nvim_create_autocmd('FileType', {
    pattern = ts_parsers,
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
