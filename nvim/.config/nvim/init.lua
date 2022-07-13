local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
  impatient.enable_profile()
end

require 'us3r.mappings'
require 'us3r.options'
-- require 'us3r.ui'
require 'us3r.catppuccin'
require 'us3r.colorscheme'
require 'us3r.icons'
require 'us3r.notify'
require 'us3r.cmp'
require 'us3r.luasnip'
require 'us3r.telescope'
require 'us3r.nvim-lsp-install'
require 'us3r.lsp'
require 'us3r.treesitter'
require 'us3r.neotree'
require 'us3r.feline'
require 'us3r.bufferline'
