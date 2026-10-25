-- [1] Install plugin
vim.pack.add({ { src = "https://github.com/rmagatti/auto-session" } })

-- [2] Setup plugin
require("auto-session").setup({
  auto_restore_enabled = false,
  auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
  session_lens = {
    picker = "snacks",
    picker_opts = {
      -- For Snacks, you can set layout options here, see:
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
      --
      preset = "dropdown",
      preview = false,
      layout = {
        width = 0.4,
        height = 0.4,
      },
    },
  }
})

-- Keybindings.
-- restore last workspace session for current directory
vim.keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "[R]estore session for cwd" })
-- save workspace session for current working directory
vim.keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "[S]ave session for cwd" })
-- save workspace session for current working directory
vim.keymap.set("n", "<leader>wf", "<cmd>AutoSession search<CR>", { desc = "[F]ind saved session" })
