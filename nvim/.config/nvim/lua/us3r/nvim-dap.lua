local status_ok, dap = pcall(require, "dap")
if not status_ok then
  vim.notify("Unable to load dap")
  return
end

dap.adapters = {
  python = {
    type = "executable",
    command = "/usr/bin/python",
    args = { "-m", "debugpy.adapter" },
  },
  cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = os.getenv("HOME") .. "/stuff/dbdadapters/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
  },
}
dap.configurations = {
  python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      pythonPath = function()
        return "python"
      end,
    },
  },
  -- cpp = {
  --   {
  --     name = "Launch (auto choose debug file)",
  --     type = "cppdbg",
  --     request = "launch",
  --     program = function()
  --       return vim.fn.expand "%:r" .. ".out"
  --     end,
  --     cwd = "${workspaceFolder}",
  --     stopOnEntry = true,
  --     runInTerminal = true,
  --   },
  --   {
  --     name = "Launch (choose debug file manually)",
  --     type = "cppdbg",
  --     request = "launch",
  --     program = function()
  --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  --     end,
  --     cwd = "${workspaceFolder}",
  --     stopOnEntry = true,
  --   },
  -- },
  rust = {
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        -- local function get_project(table)
        --   for index, value in pairs(table) do
        --     if value == "src" then
        --       return table[index - 1]
        --     end
        --   end
        -- end
        --
        -- local pname = get_project(require("user.custom.utils").split(vim.fn.expand "%", "/"))
        -- return vim.fn.expand "%:h" .. "/../target/debug/" .. pname
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
      runInTerminal = true,
    },
  },
}
-- get notify
local function start_session(_, _)
  local info_string = string.format("%s", dap.session().config.program)
  vim.notify(info_string, "debug", { title = "Debugger Started", timeout = 500 })
end

local function terminate_session(_, _)
  local info_string = string.format("%s", dap.session().config.program)
  vim.notify(info_string, "debug", { title = "Debugger Terminated", timeout = 500 })
end

dap.listeners.after.event_initialized["dapui"] = start_session
dap.listeners.before.event_terminated["dapui"] = terminate_session
-- Define symbols
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })
