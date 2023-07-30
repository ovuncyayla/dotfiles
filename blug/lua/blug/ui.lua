local U = {}

local C = require("blug.config"):get()

U.create_win = function(buffid)
  C.windowid = vim.api.nvim_open_win(
    buffid or C.scratchpadid,
    true,
    C.scratchpad
  )
  C.hidden = false
end

U.create_buf = function()
  C.scratchpadid = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(C.scratchpadid, C.buff_name)
  return C.scratchpadid
end

U.create_scratch_pad = function()
  U.create_buf()
  U.create_win()
end

return U
