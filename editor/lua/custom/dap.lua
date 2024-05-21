local dap = require("dap")

-- dap.adapters.codelldb = {
--   type = "server",
--   port = "${port}",
--   executable = {
--     command = "/usr/bin/codelldb",
--     args = { "--port", "${port}" },
--   },
-- }

-- dap.adapters.gdb = {
--   type = "executable",
--   command = "gdb",
--   args = { "-i", "dap" }
-- }

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}

dap.configurations.c = {

	-- {
	-- 	name = "Launch with GDB",
	-- 	type = "gdb",
	-- 	request = "launch",
	-- 	-- program = require("utils").dap_pick_exec,
	-- 	-- program = function()
	-- 	--   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	-- 	-- end,
	-- 	cwd = "${workspaceFolder}",
	-- 	stopAtBeginningOfMainSubprogram = false,
	-- 	-- args = function()
	-- 	--   -- Get the arguments from the user
	-- 	--   local input_args = vim.fn.input('Program arguments: ')
	-- 	--   return vim.split(input_args, " ", { trimempty = true })
	-- 	-- end,
	-- 	-- stdio = function()
	-- 	--   -- Get the path to the file to be used as stdin
	-- 	--   local stdin_file = vim.fn.input('Path to stdin file: ')
	-- 	--   if stdin_file == '' then
	-- 	--     return nil
	-- 	--   end
	-- 	--   return { stdin_file, nil, nil }
	-- 	-- end,
	-- 	-- sourceLanguages = { "c" },
	-- },

	{
		name = "Launch with LLDB",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		-- args = " < asd",
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
		runInTerminal = true,

		stdio = function()
			-- Get the path to the file to be used as stdin
			local stdin_file = vim.fn.input("Path to stdin file: ")
			if stdin_file == "" then
				return nil
			end
			return { stdin_file, nil, nil }
		end,
	},

	-- {
	-- 	type = "codelldb",
	-- 	request = "launch",
	-- 	name = "Launch file",
	-- 	program = "${file}",
	-- 	-- pythonPath = function()
	-- 	--   return "/usr/bin/python"
	-- 	-- end,
	-- },
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

dap.configurations.rust = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

dap.configurations.rust = dap.configurations.c

dap.adapters.python = {
	type = "executable",
	command = "python3",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return "python"
		end,
	},
}

-- dap.adapters['pwa-node'] = {
--   type = 'executable',
--   -- command = 'node',
--   -- args = {os.getenv('HOME') .. '/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter'},
--   command = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter',
-- }

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = 8123,
}

dap.configurations["typescriptreact"] = {
	{
		-- Name of the configuration
		name = "Launch Next.js App",
		type = "pwa-node",
		request = "launch",
		program = "${workspaceFolder}/node_modules/next/dist/bin/next",
		cwd = "${workspaceFolder}",
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		env = {
			NODE_ENV = "development",
		},
		args = { "dev" },
	},
	{
		-- Attach configuration
		name = "Attach to Next.js App",
		type = "pwa-node",
		request = "attach",
		-- processId = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
		sourceMaps = true,
		protocol = "inspector",
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

local dapui = require("dapui")
dapui.setup({
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
})
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
require("dap.ext.vscode").json_decode = require("overseer.json").decode
require("dap.ext.vscode").load_launchjs(nil, { lldb = { "c", "cpp", "rs" } })

local api = vim.api
local debuggerkeys = {
	["<F6>"] = "<Cmd>DapStepOver<CR>",
	["<F7>"] = "<Cmd>DapStepInto<CR>",
	["<F8>"] = "<Cmd>DapContinue<CR>",
	["<F9>"] = "<Cmd>DapStepOut<CR>",
	["<leader>b"] = "<Cmd>DapToggleBreakpoint<CR>",
}

for key, keymap in pairs(debuggerkeys) do
	api.nvim_set_keymap("n", key, keymap, { desc = keymap })
end

-- local keymap_restore = {}
-- local DapStarter = "<F3>"
-- api.nvim_set_keymap("n", DapStarter, "<Cmd>DapContinue<CR>", { silent = true })
--
-- local function  keymapstore()
-- 	for _, buf in pairs(api.nvim_list_bufs()) do
-- 		local keymaps = api.nvim_buf_get_keymap(buf, "n")
-- 		for _, keymap in pairs(keymaps) do
-- 			if debuggerkeys[keymap.lhs] ~= nil then
-- 				table.insert(keymap_restore, keymap)
-- 				api.nvim_buf_del_keymap(buf, "n", keymap.lhs)
-- 			end
-- 		end
-- 		for key, keymap in pairs(debuggerkeys) do
-- 			print(key)
-- 			api.nvim_buf_set_keymap(buf, "n", key, keymap, {})
-- 		end
-- 	end
-- end
--
-- local function keymaprestore()
--   for _, keymap in pairs(keymap_restore) do
--     api.nvim_buf_set_keymap(
--       keymap.buffer,
--       keymap.mode,
--       keymap.lhs,
--       keymap.rhs,
--       { silent = keymap.silent == 1 }
--     )
--   end
--   keymap_restore = {}
-- end
--
-- dap.listeners.after.event_initialized["customdapextension"] = function()
-- 	keymapstore()
-- end
--
-- dap.listeners.before.event_exited["customdapextension"] = function()
-- 	keymaprestore()
-- end
--
