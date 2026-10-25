-- [1] Installing
vim.pack.add({
  "https://github.com/dasupradyumna/midnight.nvim",
})

-- [2] Setup/Configuring
require("midnight").setup({
  -- optional configuration here
  -- transparent = false,
})

vim.cmd("colorscheme midnight")
