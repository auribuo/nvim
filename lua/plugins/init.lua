local function pack(shorts)
    for _, short in ipairs(shorts) do
        vim.pack.add { 'https://github.com/' .. short }
    end
end

pack {
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
    'rktjmp/lush.nvim',
    'nvim-lualine/lualine.nvim',
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
}

require('plugins.lualine').setup()
require('plugins.bufferline').setup()
require('plugins.treesitter')
require('plugins.lsp')
require('plugins.fzf')
require('plugins.blink')
require('plugins.toggleterm')
require('plugins.whichkey')

require('oil').setup {}
require('nvim-autopairs').setup {}

vim.g.VM_silent_exit = 1
vim.g.VM_show_warnings = 0
