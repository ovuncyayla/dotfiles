M = {}
local scratchpad_buf_id = -1

vim.api.nvim_create_user_command("BLugEnable", function(args)
  if vim.fn.bufexists('BLug Scratchpad') <= 0 then
    scratchpad_buf_id = M.create_scratch_pad()
    -- vim.notify("Creating scratch pad " .. scratchpad_buf_id)
    return
  end
  vim.notify("Deleting Scratchpad")
  vim.api.nvim_buf_delete(scratchpad_buf_id, { force = true })
  -- vim.pretty_print(args)
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


local function set_buffer_opts()
     vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
       pattern = {"*Blug Scratchpad*"},
       callback = function(ev)
         vim.notify(string.format('event fired: s', vim.inspect(ev)))
          vim.api.nvim_buf_set_option(0, 'filetype', 'lua')
          vim.api.nvim_buf_set_option(0, 'buftype', 'acwrite')
          vim.api.nvim_buf_call(0, function () vim.cmd("LspStart") end)
       end
     })
end


function M.create_scratch_pad()
  scratchpad_buf_id = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_name(scratchpad_buf_id, 'BLug Scratchpad')
  -- vim.api.nvim_buf_set_option(scratchpad_buf_id, 'filetype', 'lua')
  -- vim.api.nvim_buf_set_option(scratchpad_buf_id, 'buftype', 'acwrite')
  -- vim.api.nvim_buf_call(scratchpad_buf_id, function () vim.cmd("LspStart") end)

  local width = vim.o.columns * 0.85
  local height = vim.o.lines * 0.8

  local win_opts = {
    relative = 'editor',
    width = math.floor(width),
    height = math.floor(height),
    col = math.floor((vim.o.columns / 2) - (width / 2)),
    row = math.floor((vim.o.lines / 2) - (height / 2)),
    anchor = 'NW',
    border = 'rounded',
    zindex = 1,
  }

  vim.api.nvim_open_win(scratchpad_buf_id, true, win_opts)

  return scratchpad_buf_id
end


vim.keymap.set("n", "<F8>", "<cmd>BLugEnable<cr>")
