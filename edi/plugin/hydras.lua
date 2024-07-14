local Hydra = require('hydra')

Hydra({
   name = 'Side scroll',
   mode = 'n',
   body = 'z',
   heads = {
      { 'h', '5zh' },
      { 'l', '5zl', { desc = 'â†/â†’' } },
      { 'H', 'zH' },
      { 'L', 'zL', { desc = 'half screen â†/â†’' } },
   }
})


Hydra({
   name = 'Resize win',
   mode = 'n',
   body = '<C-w>',
   heads = {
      { '+', '5<C-w>+', { desc = "ğŸ  / Increase Height" } },
      { '-', '5<C-w>-', { desc = "ğŸ Ÿ / Decrease Height" } },
      { '_', '<C-w>_',  { desc = "î‰ / Max Out Height" } },
      { '=', '<C-w>=',   { desc = "î‰¹  / Equally High and Wide" } },
      { '>', '5<C-w>>', { desc = "ğŸ  / Increase Width" } },
      { '<', '5<C-w><', { desc = "ğŸ œ / Decrease Width÷¸†»ù¾´€÷¸‡" } },
      { '|', '<C-w>|',  { desc = "âŸº  / Max Out Width÷¸†»ù¾´€÷¸‡" } },
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

