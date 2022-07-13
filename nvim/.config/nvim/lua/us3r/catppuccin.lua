local ok, catppuccin = pcall(require, "catppuccin")
if ok then
catppuccin.setup ({
integrations = {
  treesitter = true,
  native_lsp = {
    enabled = true,
    virtual_text = {
      errors = "italic",
      hints = "italic",
      warnings = "italic",
      information = "italic",
    },
    underlines = {
      errors = "underline",
      hints = "underline",
      warnings = "underline",
      information = "underline",
    },
  },
  lsp_trouble = false,
  cmp = true,
  lsp_saga = false,
  gitgutter = false,
  gitsigns = true,
  telescope = true,
  nvimtree = {
    enabled = false,
    show_root = false,
    transparent_panel = false,
  },
  neotree = {
    enabled = true,
    show_root = true,
    transparent_panel = false,
  },
  which_key = false,
  indent_blankline = {
    enabled = true,
    colored_indent_levels = true,
  },
  dashboard = false,
  neogit = false,
  vim_sneak = false,
  fern = false,
  barbar = false,
  bufferline = true,
  markdown = true,
  lightspeed = false,
  ts_rainbow = true,
  hop = true,
  notify = true,
  telekasten = false,
  symbols_outline = false,
},
})
else
  vim.notify("Unable to load catppuccin!")
end
