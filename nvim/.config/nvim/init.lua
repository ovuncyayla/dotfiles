local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
  impatient.enable_profile()
end

require 'us3r.mappings'
require 'us3r.options'
require 'us3r.ui'
require 'us3r.telescope'
require 'us3r.neotree'
