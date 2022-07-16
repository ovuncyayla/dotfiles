local impatient_ok, impatient = pcall(require, "impatient")
if not impatient_ok then
  vim.notify('Unable to load impatient')
  return
end

impatient.enable_profile()

