local U = {}

local C = require("blug.config"):get()

U.create_win = function(buffid)
  C.windowid = vim.api.nvim_open_win(
    buffid or C.scratchpadid,
    true,
    C.scratchpad
  )
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

U.create_results_win = function(results)

  local buffid = vim.api.nvim_create_buf(false, true)
  local lines = vim.split(vim.inspect(results), "\n")
  vim.api.nvim_buf_set_option(buffid, 'filetype', 'lua')
  vim.api.nvim_buf_set_option(buffid, 'buftype', 'nofile')
  vim.api.nvim_buf_set_name(buffid, 'BlugEvalResults')
  vim.api.nvim_buf_set_lines(buffid, 0, -1, false, lines)
  -- make buffer readonly
  vim.api.nvim_buf_set_option(buffid, 'readonly', true)
  vim.api.nvim_buf_set_option(buffid, 'modifiable', false)
  vim.api.nvim_buf_set_option(buffid, 'modified', false)


  vim.api.nvim_create_autocmd('BufLeave', {
    callback = function()
      pcall(vim.api.nvim_buf_delete, buffid, { force = true })
    end,
    buffer = buffid,
  })

  -- prevent going to insert mode in the results buffer
  vim.keymap.set('n', 'i', '<NOP>', { buffer = buffid })
  -- map q and esc to :q in the results buffer
  vim.keymap.set('n', 'q', ':q<CR>', { buffer = buffid })
  vim.keymap.set('n', '<ESC>', ':q<CR>', { buffer = buffid })


  local width = math.floor(vim.o.columns / 3)
  local height = math.floor(vim.o.lines / 2)

  local opts = {
    width = math.floor(width),
    height = math.floor(height),
    col = math.floor((vim.o.columns / 2) - (width / 2)),
    row = math.floor((vim.o.lines / 2) - (height / 2)),
    relative = 'editor',
    anchor = 'NW',
    border = 'rounded',
    zindex = 1,
  }
  vim.api.nvim_open_win(buffid, true, opts)
end

return U
