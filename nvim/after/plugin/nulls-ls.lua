local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")

null_ls.setup({
    sources = {
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        -- Lua
        null_ls.builtins.formatting.stylua,
    },
})

mason_null_ls.setup({
    automatic_installation = true, -- Install configured sources automatically
})
