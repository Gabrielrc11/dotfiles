-- Native nvim 0.12 undotree
-- 1. Ativa o plugin nativo
vim.cmd.packadd("nvim.undotree")

-- 2. Cria o atalho 'U' para abrir e fechar a árvore de undo
vim.keymap.set("n", "U", "<cmd>Undotree<CR>", { desc = "Toggles Undotree" })
