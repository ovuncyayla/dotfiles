local jdtls = require("jdtls")
local jdtls_config =  require("custom.nvim-jdtls")

local fun = function (bufnr)
  vim.notify("Buffnr: " .. "bufi")
    vim.notify("Some notification here!!!!")
    jdtls.start_or_attach(jdtls_config)
    vim.notify("Some notification here!")
end

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
  pattern = { "*.java", "pom.xml", },
  -- callback = function ()
    -- vim.notify("Some notification here!!!!")
    -- jdtls.start_or_attach(jdtls_config)
    -- vim.notify("Some notification here!")
  -- end
  callback = fun

})




