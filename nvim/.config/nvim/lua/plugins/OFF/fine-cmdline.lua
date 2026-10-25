vim.pack.add({
  { src = "https://github.com/VonHeikemen/fine-cmdline.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" }
})

vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
