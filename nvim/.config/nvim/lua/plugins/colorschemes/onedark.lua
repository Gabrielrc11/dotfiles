-- [1] Installing
vim.pack.add({
  "https://github.com/navarasu/onedark.nvim",
})

-- [2] Setup/Configuring
require("onedark").setup({
  transparent = false,
  styles = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
})
require("onedark").load()

-- [3] Define colorscheme
vim.cmd("colorscheme onedark")
