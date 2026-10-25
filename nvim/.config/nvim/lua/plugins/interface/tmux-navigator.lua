-- [1] Installing
-- NOTE: This is a vim script plugin, not a lua plugin!
vim.pack.add({ { src = "https://github.com/christoomey/vim-tmux-navigator" } })

-- Diz pro vim-tmux-navigator para NÃO criar os mapeamentos de ctrl+h/j/k/l --
-- quem vai criar esses mapeamentos agora é o vim-herdr-navigation.
vim.g.tmux_navigator_no_mappings = 1

-- Setup keybindings
-- vim.keymap.set("n", "<c-h>", "<cmd><C-U>TmuxNavigateLeft<CR>", { desc = "Tmux navigate left" })
-- vim.keymap.set("n", "<c-j>", "<cmd><C-U>TmuxNavigateDown<CR>", { desc = "Tmux navigate down" })
-- vim.keymap.set("n", "<c-k>", "<cmd><C-U>TmuxNavigateUp<CR>", { desc = "Tmux navigate up" })
-- vim.keymap.set("n", "<c-l>", "<cmd><C-U>TmuxNavigateRight<CR>", { desc = "Tmux navigate right" })
vim.keymap.set("n", "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<CR>", { desc = "Tmux navigate previous" })

-- dofile(vim.fn.expand("/home/selan/.config/nvim/after/plugin/herdr_nav.lua"))
