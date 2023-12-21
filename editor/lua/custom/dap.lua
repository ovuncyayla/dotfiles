local dap = require("dap")

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/usr/bin/codelldb',
    args = { "--port", "${port}" },
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


dap.adapters = {
  python = {
    type = "executable",
    command = "/usr/bin/python",
    args = { "-m", "debugpy.adapter" },
  }
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
}

-- dap.adapters['pwa-node'] = {
--   type = 'executable',
--   -- command = 'node',
--   -- args = {os.getenv('HOME') .. '/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter'},
--   command = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter',
-- }


dap.adapters['pwa-node'] = {
  type = 'server',
  host = "localhost",
  port = 8123
}


dap.configurations['typescriptreact'] = {
  {
    -- Name of the configuration
    name = 'Launch Next.js App',
    type = 'pwa-node',
    request = 'launch',
    program = '${workspaceFolder}/node_modules/next/dist/bin/next',
    cwd = '${workspaceFolder}',
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    env = {
      NODE_ENV = "development",
    },
    args = { 'dev' },
  },
  {
    -- Attach configuration
    name = 'Attach to Next.js App',
    type = 'pwa-node',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
    cwd = '${workspaceFolder}',
    sourceMaps = true,
    protocol = 'inspector',
  },
}

-- dap.adapters.lldb = {
--   type = 'executable',
--   command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
--   name = 'lldb'
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


require("nvim-dap-virtual-text").setup({})
