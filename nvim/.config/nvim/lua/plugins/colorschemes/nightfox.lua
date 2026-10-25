-- [1] Installing
vim.pack.add({ { src = "https://github.com/EdenEast/nightfox.nvim" } })

-- [2] Setup/Configuring
require("nightfox").setup({
  options = {
    transparent = false,
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    },
  },
})

-- Options are:
-- Nightfox
-- Dayfox
-- Dawnfox
-- Duskfox
-- Nordfox
-- Terafox
-- Carbonfox

-- Execute only when needed (after 1st installation or any upgrade).
-- vim.cmd("NightfoxCompile")

-- [3] Define colorscheme
-- vim.cmd("colorscheme nightfox")
-- vim.cmd("colorscheme nordfox")
-- vim.cmd("colorscheme terafox")
