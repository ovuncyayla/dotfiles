local Hydra = require('hydra')

Hydra({
   name = 'Side scroll',
   mode = 'n',
   body = 'z',
   heads = {
      { 'h', '5zh' },
      { 'l', '5zl', { desc = 'โ/โ' } },
      { 'H', 'zH' },
      { 'L', 'zL', { desc = 'half screen โ/โ' } },
   }
})

Hydra({
   name = 'Resize win',
   mode = 'n',
   body = '<C-w>',
   heads = {
      { '+', '5<C-w>+', { desc = "๐  / Increase Height" } },
      { '-', '5<C-w>-', { desc = "๐  / Decrease Height" } },
      { '_', '<C-w>_',  { desc = "๎ / Max Out Height" } },
      { '=', '<C-w>=',   { desc = "๎น  / Equally High and Wide" } },
      { '>', '5<C-w>>', { desc = "๐  / Increase Width" } },
      { '<', '5<C-w><', { desc = "๐  / Decrease Width๗ธป๙พด๗ธ" } },
      { '|', '<C-w>|',  { desc = "โบ  / Max Out Width๗ธป๙พด๗ธ" } },
   }
})

-- Hydra({
--    color = 'pink',
--    name = 'DAP Control',
--    mode = 'n',
--    body = '<F8>',
--    heads = {
--       { '<F6>', '<Cmd>DapStepOver<CR>', { desc = "Step Over" } },
--       { '<F7>', '<Cmd>DapStepInto<CR>', { desc = "Step Into" } },
--       { '<F8>', '<Cmd>DapContinue<CR>', { desc = "Continue" } },
--       { '<F9>', '<Cmd>DapStepOut <CR>',  { desc = "Step Out" } },
--    }
-- })

