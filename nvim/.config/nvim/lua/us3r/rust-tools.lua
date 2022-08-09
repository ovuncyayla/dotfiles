local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
  vim.notify("Unable to load rust_tools")
  return
end
-- local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.6.7/'
-- local extension_path = '/home/us3r/stuff/codelldb-x86_64-linux/extension/adapter/codelldb'
local extension_path = '/home/us3r/stuff/codelldb-x86_64-linux/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local opts = {
    -- ... other configs
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
}

require('rust-tools').setup(opts)
