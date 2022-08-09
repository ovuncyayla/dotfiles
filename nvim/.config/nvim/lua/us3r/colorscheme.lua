local colorscheme = 'tokyonight'

local ok, _ = pcall(require, colorscheme)
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
vim.g.tokyonight_style = "night"
vim.cmd[[colorscheme tokyonight]]
