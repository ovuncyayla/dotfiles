local Config = {
  state = {},
  config = {
    buff_name = "BLug Scratchpad",
    scratchpad  = {
      width = 0.8,
      height = 0.8,
      border = "rounded"
    }
  }
}

function Config:new(opts)
  opts = opts or {}

  local width = vim.o.columns * (opts.width or 0.85)
  local height = vim.o.lines * (opts.height or 0.8)

  local size_opts = {
    width = math.floor(width),
    height = math.floor(height),
    col = opts.col or math.floor((vim.o.columns / 2) - (width / 2)),
    row = opts.row or math.floor((vim.o.lines / 2) - (height / 2)),
  }

  local style_opts = {
    relative = 'editor',
    anchor = 'NW',
    border = 'rounded',
    zindex = 1,
  }

  self.config.scratchpad = vim.tbl_deep_extend("force", self.config.scratchpad, style_opts, opts, size_opts)
  return self
end

function Config:get()
  return self.config
end

setmetatable(Config, {
  __index = function (self, k)
    return self.state[k]
  end,
  __new_index = function (self, k, v)
    self.state[k] = v
    --vim.print(self)
  end
})

return Config
