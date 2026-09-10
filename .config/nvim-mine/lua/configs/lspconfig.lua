require("nvchad.configs.lspconfig").defaults()

-- Ported from the old nvchad-custom config, which registered these with the
-- NvChad v2.0 API (require "lspconfig" + per-server .setup{}). The v2.5
-- starter uses vim.lsp.enable instead; the server list is the part that was
-- actually customised, so only that is carried over.
local servers = { "pylsp", "marksman", "bashls", "terraformls", "yamlls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
