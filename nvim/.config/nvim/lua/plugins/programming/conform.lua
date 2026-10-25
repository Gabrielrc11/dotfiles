-- Adicionar os plugins necessários
vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })

-- Load and setup conform.
local ok, conform = pcall(require, "conform")
if ok then
  conform.setup({
    formatters_by_ft = {
      cpp = { "clang_format" },
      lua = { "stylua" },
      rust = { "rustfmt" },
      nix = { "nixfmt" },
      -- python = { "isort", "black" },
      markdown = { "prettier" }, -- Removi 'marksman' que não é um formatador
      latex = { "latexindent" }, -- Removi 'tex-fmt' que pode não existir
    },

    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        -- print("Autoformatting is DISABLED!")
        return
      end
      -- print("Autoformatting is ENABLED!")
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,

    -- Additional language-specific formatting options.
    -- formatters = {
    --   stylua = {
    --     prepend_args = { '--indent-type', 'Spaces', '--indent-width', '2' },
    --   },
    -- },
  })
end

-- -- Ou usando vim.defer_fn para garantir que o plugin está carregado
-- vim.defer_fn(function()
--   require('conform').setup({
--     -- mesma configuração acima
--   })
-- end, 100)

-- Configuração de keymaps (mantenha separado)
vim.keymap.set("n", "=", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer or range (in visual mode)" })
