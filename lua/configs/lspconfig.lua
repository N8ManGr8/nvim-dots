require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "stylua" }
vim.lsp.enable(servers)

vim.lsp.inlay_hint.enable(true)
