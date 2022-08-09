local lspconfig = require "lspconfig"

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = true,
  signs = { active = signs },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local servers = require "us3r.lsp.servers"
local installer_avail, lsp_installer = pcall(require, "nvim-lsp-installer")

-- if installer_avail then
--   for _, server in ipairs(lsp_installer.get_installed_servers()) do
--     table.insert(servers, server.name)
--   end
-- end

local handlers = require("us3r.lsp.handlers")
for _, server in pairs(servers) do
	local opts = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "us3r.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	-- vim.notify("Configuring server " .. server)
	lspconfig[server].setup(opts)
end
