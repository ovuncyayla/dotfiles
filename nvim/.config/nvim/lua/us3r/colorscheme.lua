local colorscheme = 'catppuccin'

local ok, catppuccin = pcall(require, colorscheme)
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

local ok, _ = pcall(vim.cmd("colorscheme " .. colorscheme))
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
