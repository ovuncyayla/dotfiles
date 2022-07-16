local status_ok, notify = pcall(require, "notify")
if status_ok then
  notify.setup({ stages = "slide" })
  vim.notify = notify
else
  vim.notify("Unable to load notify")
end
