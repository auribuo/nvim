require("toggleterm").setup {
    open_mapping = [[<a-i>]],
    size = 40,
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    terminal_mappings = true,
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true,
    insert_mappings = true,
    shell = vim.o.shell or "sh",
    float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
            border = "FloatBorder",
            background = "Normal",
        }
    }
}
