-- [1] Installing
vim.pack.add({ { src = "https://github.com/rose-pine/neovim" } })

-- Setup/Configuring
require("rose-pine").setup({
  --- @usage 'auto'|'main'|'moon'|'dawn'
  variant = "moon",
  disable_background = false,
}) -- on/off transparency
