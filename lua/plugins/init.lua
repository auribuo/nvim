local function pack(shorts)
    local plugins = {}
    for _, short in ipairs(shorts) do
        table.insert(plugins, 'https://github.com/' .. short)
    end
    vim.pack.add(plugins, {})
end

pack {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
    'ibhagwan/fzf-lua',
    'nvim-treesitter/nvim-treesitter',
    'rktjmp/lush.nvim',
    'nvim-lualine/lualine.nvim',
    'arkav/lualine-lsp-progress',
    'saghen/blink.cmp',
    'nvim-mini/mini.icons',
    'stevearc/oil.nvim',
    'wakatime/vim-wakatime',
    'mg979/vim-visual-multi',
    'windwp/nvim-autopairs',
    'akinsho/toggleterm.nvim',
    'akinsho/bufferline.nvim',
    'nvim-tree/nvim-web-devicons',
    'ibhagwan/fzf-lua',
    'folke/which-key.nvim',
    'lewis6991/gitsigns.nvim',
    'nvimtools/none-ls.nvim',
    'stevearc/aerial.nvim',
    'MeanderingProgrammer/render-markdown.nvim',
}
vim.cmd.packadd("nvim.undotree")

require('plugins.lualine').setup()
require('plugins.bufferline').setup()
require('plugins.treesitter')
require('plugins.lsp')
require('plugins.fzf')
require('plugins.blink')
require('plugins.toggleterm')
require('plugins.whichkey')
require('plugins.nonels')

require('oil').setup {}
require('nvim-autopairs').setup {}
require('aerial').setup {}
require('render-markdown').setup {}

vim.g.VM_silent_exit = 1
vim.g.VM_show_warnings = 0
