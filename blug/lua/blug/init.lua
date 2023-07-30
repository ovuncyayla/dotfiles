local C = require("blug.config")

-- M = {}
--
-- M.setup = function(conf)
--   conf = C:set(conf)
-- end
--
-- M.setup({})
C:set({})
require("blug.api")

vim.keymap.set("n", "<F8>", "<cmd>BLugScratchToggle<cr>")

