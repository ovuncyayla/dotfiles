local U = require("blug.ui")
local C = require("blug.config")

local conf = C:get()

local hide_scratchpad = function()
  vim.api.nvim_buf_set_option(conf.scratchpadid, "modified", false)
  vim.api.nvim_win_close(conf.windowid, true)
  conf.hidden = true
end

local show_scratchpad = function()
  local bid = conf.scratchpadid or U.create_buf()
  U.create_win(bid)
  conf.hidden = false
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" .. conf["buff_name"] .. "*" },
  --group = vim.api.nvim_create_augroup("AuBLug"),
  callback = function(ev)
    vim.api.nvim_buf_set_option(0, 'filetype', 'lua')
    vim.api.nvim_buf_set_option(0, 'buftype', 'acwrite')
    vim.api.nvim_buf_call(0, function() vim.cmd("LspStart") end)
  end
})

vim.api.nvim_create_user_command("BLugScratchToggle", function(args)
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
      local sub_cmds = { 'keymaps', 'commands', 'autocmds', 'functions' }
      local comp_list = {}
      for i = 1, #sub_cmds do
        if vim.startswith(sub_cmds[i]:lower(), vim.trim(arg_lead):lower()) then
          table.insert(comp_list, sub_cmds[i])
        end
      end
      return comp_list
    end,
  })
