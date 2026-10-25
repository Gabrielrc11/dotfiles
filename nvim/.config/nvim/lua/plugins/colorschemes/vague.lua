-- [1] Installing
vim.pack.add({
  "https://github.com/vague-theme/vague.nvim",
})

-- [2] Setup/Configuring
require("vague").setup({
  -- optional configuration here
  -- transparent = false,
})

vim.cmd("colorscheme vague")
