vim.keymap.set("n", ".",
  function() vim.notify( vim.fn.expand(".") .. "/" .. vim.fn["netrw#Call"]('NetrwGetWord')) end
  , { buffer = true })

