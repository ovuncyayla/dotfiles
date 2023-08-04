local U = require("blug.ui")
local C = require("blug.config")

local conf = C:get()

local hide_scratchpad = function()
  if vim.api.nvim_buf_is_valid(conf.scratchpadid or -666) then
    vim.api.nvim_buf_set_option(conf.scratchpadid, "modified", false)
  end
  if vim.api.nvim_win_is_valid(conf.windowid or -666) then
    vim.api.nvim_win_close(conf.windowid, true)
  end
  conf.hidden = true
end

local show_scratchpad = function()
  local bid = conf.scratchpadid
  if not vim.api.nvim_buf_is_valid(bid or -666) then
    bid = U.create_buf()
  end
  U.create_win(bid)
  conf.hidden = false
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPre" }, {
  pattern = { "*" .. conf["buff_name"] .. "*" },
  group = vim.api.nvim_create_augroup("AuBlug", { clear = true }),
  callback = function(ev)
    vim.api.nvim_buf_set_option(0, 'filetype', 'lua')
    vim.api.nvim_buf_set_option(0, 'buftype', 'acwrite')
    -- vim.lsp.start({
    --   name = 'lua_ls',
    --   cmd = {'lua-language-server'},
    --   root_dir = vim.loop.fs_realpath(vim.fn.stdpath("config"))
    -- })
  end
})

vim.api.nvim_create_user_command("BlugScratchToggle", function(args)
  if conf.hidden == nil or conf.hidden then
    show_scratchpad()
  else
    hide_scratchpad()
  end
end,
  {
    nargs = '*',
    desc = 'Find keymaps and commands with vim.ui.select()',
    force = true,
    complete = function(arg_lead)
      local sub_cmds = {} -- { 'keymaps', 'commands', 'autocmds', 'functions' }
      local comp_list = {}
      for i = 1, #sub_cmds do
        if vim.startswith(sub_cmds[i]:lower(), vim.trim(arg_lead):lower()) then
          table.insert(comp_list, sub_cmds[i])
        end
      end
      return comp_list
    end,
  }
)

-- TODO: Make it context aware with TS
vim.api.nvim_create_user_command("BlugEvalLine", function(args)
  local line = vim.api.nvim_get_current_line()

  local _, res = pcall(function () return vim.fn.eval(line) end)
  U.create_results_win(res)
end, {
  desc = 'Eval Line and show results in a float',
  force = true
})


