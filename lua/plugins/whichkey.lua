require('which-key').setup {
    delay = function(ctx)
        if
            ctx.keys:sub(1, 1) == '"' or
            ctx.keys:sub(1, 1) == "`" or
            ctx.keys == '<C-R>' or
            ctx.keys:sub(1, 1) == "'" then
            return 100
        end
        return 2000
    end
}
