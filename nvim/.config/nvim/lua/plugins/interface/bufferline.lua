-- [1] Install plugin
vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim", version = "v4.9.1" } })

-- [2] Setup plugin
require("bufferline").setup({
  options = {
    always_show_bufferline = false, -- Show tabs only if we have 2 or more buffers open.
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    indicator = {
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "icon",
    },
  },
})

-- [3] Define global variable for toggle support
vim.g.bufferline_visible = true
