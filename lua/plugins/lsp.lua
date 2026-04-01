local lang_servers = { 'lua_ls' }

for _, ls in ipairs(lang_servers) do
    vim.lsp.enable(ls)
end
vim.lsp.config('*', {
    on_init = function(client, _)
        -- if client.supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
        -- end
    end,
    capabilities = vim.lsp.protocol.make_client_capabilities()
})
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
                library = {
                    vim.fn.expand '$VIMRUNTIME/lua'
                }
            }
        }
    }
})
