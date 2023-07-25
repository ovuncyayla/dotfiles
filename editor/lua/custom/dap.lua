local dap = require("dap")

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/usr/bin/codelldb',
    args = {"--port", "${port}"},
  }
}

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

-- dap.adapters.lldb = {
--   type = 'executable',
--   command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
--   name = 'lldb'
-- }


-- dap.adapters = {
--   python = {
--     type = "executable",
--     command = "/usr/bin/python",
--     args = { "-m", "debugpy.adapter" },
--   },
--   cppdbg = {
--     id = "cppdbg",
--     type = "executable",
--     command = os.getenv("HOME") .. "/stuff/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7"
--   },
--   lldb = {
--           type = 'executable',
--           attach = {pidProperty = "pid", pidSelect = "ask"},
--           command = 'lldb-vscode',
--           name = "lldb",
--           env = {LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"}
--       }
--
-- }

-- dap.configurations = {
--   python = {
--     {
--       type = "python",
--       request = "launch",
--       name = "Launch file",
--       program = "${file}",
--       pythonPath = function()
--         return "python"
--       end,
--     },
--   },
--   -- cpp = {
--   --   {
--   --     name = "Launch (auto choose debug file)",
--   --     type = "cppdbg",
--   --     request = "launch",
--   --     program = function()
--   --       return vim.fn.expand "%:r" .. ".out"
--   --     end,
--   --     cwd = "${workspaceFolder}",
--   --     stopOnEntry = true,
--   --     runInTerminal = true,
--   --   },
--   --   {
--   --     name = "Launch (choose debug file manually)",
--   --     type = "cppdbg",
--   --     request = "launch",
--   --     program = function()
--   --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--   --     end,
--   --     cwd = "${workspaceFolder}",
--   --     stopOnEntry = true,
--   --   },
--   -- },
--   rust = {
--     {
--       name = "Launch file",
--       type = "cppdbg",
--       request = "launch",
--       program = function()
--         -- local function get_project(table)
--         --   for index, value in pairs(table) do
--         --     if value == "src" then
--         --       return table[index - 1]
--         --     end
--         --   end
--         -- end
--         --
--         -- local pname = get_project(require("user.custom.utils").split(vim.fn.expand "%", "/"))
--         -- return vim.fn.expand "%:h" .. "/../target/debug/" .. pname
--         return vim.fn.getcwd() .. "/target/debug/cj"
--         -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--       end,
--       cwd = "${workspaceFolder}",
--       args = function ()
--         return {"-p", "test.json"}
--       end ,
--       stopOnEntry = true,
--       runInTerminal = true,
--     MIMode= "gdb",
--     miDebuggerPath= "/home/us3r/.cargo/bin/rust-gdb"
--     },
--   },
-- }


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


local dapui = require "dapui"
dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    expand = "<cr>",
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    border = "single",
    mappings = {
      close = { "q", "<esc>" },
    },
  },
  windows = { indent = 1 },
}
-- add listeners to auto open DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


require("nvim-dap-virtual-text").setup()

