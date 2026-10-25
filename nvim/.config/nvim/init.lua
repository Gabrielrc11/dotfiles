-- Main point of entry to other config files.
require("config.options")
require("plugins")
require("config.autocommands")

-- NOTE:
-- This must be called after `require("plugins")`, because it adds some capabilities exposed by some plugins.
-- For instance, `blink.cmp` and `nvim-ufo`.
require("config.enable_lsp")

-- -- Make sure all help documentation are loaded.
-- vim.schedule(function()
--   vim.cmd("helptags ALL")
-- end)
