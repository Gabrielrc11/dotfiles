-- [1] Installing
vim.pack.add({ { src = "https://github.com/rebelot/kanagawa.nvim" } })

-- [2] Setup/Configuring
require("kanagawa").setup({
  compile = true,
  transparent = false,
  theme = "wave",
})

-- Execute only when needed (after 1st installation or any upgrade).
vim.cmd("KanagawaCompile")

-- [3] Define colorscheme
vim.cmd("colorscheme kanagawa-wave")
-- vim.cmd("colorscheme kanagawa-dragon")
-- vim.cmd("colorscheme kanagawa-lotus")
