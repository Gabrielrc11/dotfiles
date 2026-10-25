-- Add plugin
vim.pack.add({ { src = "https://github.com/folke/trouble.nvim" } })

local trouble = require("trouble")
-- Configuração padrão (equivalente a opts = {})
trouble.setup({
  -- -- Configurações padrão - você pode personalizar aqui se necessário
  -- modes = {
  --   test = {
  --     mode = "diagnostics",
  --     preview = {
  --       type = "split",
  --       relative = "win",
  --       position = "right",
  --       size = 0.3,
  --     },
  --   },
  -- },
})

-- Keymaps
vim.keymap.set("n", "<leader>tx", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, desc = "Diagnosti[x]cs" })
vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", { silent = true, desc = "[S]ymbols" })
vim.keymap.set(
  "n",
  "<leader>tl",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { silent = true, desc = "[l]SP Definitions / references / ... " }
)
vim.keymap.set("n", "<leader>tL", "<cmd>Trouble loclist toggle<cr>", { silent = true, desc = "[L]ocation List" })
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { silent = true, desc = "[q]uickfix List" })
