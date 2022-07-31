local status_ok, which_key = pcall(require, "which-key")

if not status_ok then
  vim.notify("Unable to load which-key")
  return
end

which_key.setup({})

