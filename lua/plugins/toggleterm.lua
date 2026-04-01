require("toggleterm").setup {
    size = 25,
    open_mapping = [[<c-i>]],
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved'
        winblend = 0,
        highlights = {
            border = "FloatBorder",
            background = "Normal",
        }
    }
}
