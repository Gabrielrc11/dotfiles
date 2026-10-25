-- [1] Installing
vim.pack.add({
  "https://github.com/metalelf0/black-metal-theme-neovim",
})

-- [2] Setup/Configuring
require("black-metal").setup({
  -- optional configuration here
  -- transparent = false,
  theme = "bathory",
  variant = "dark",
})

vim.cmd("colorscheme bathory")
