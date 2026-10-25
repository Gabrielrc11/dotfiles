vim.pack.add({ { src = "https://github.com/mfussenegger/nvim-lint" } })

-- import lint
local has_lint, lint = pcall(require, "lint")
if not has_lint then
  vim.notify("Missing 'nvim-lint' plugin.")
  return
end

lint.linters_by_ft = {
  -- =============================================================================================
  -- NOTE: the linter for cpp is called when setting clangd LSP,
  -- (see clang.lua in plugins.lsp.settings).
  -- If we call it here, it generates imprecise messages, somehow.
  ------------------------------------------------------------------------------------------------
  -- cpp = { "cpplint" },
  cpp = { "clangtidy" },
  -- =============================================================================================
  lua = { "luacheck" },
  -- python = { "pylint" },
  markdown = { "markdownlint", "write_good" },
  latex = { "latexindent", "write_good" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- vim.keymap.set("n", "<leader>a", function()
--   local lint_progress = function()
--     local linters = require("lint").get_running()
--     if #linters == 0 then
--       return "󰦕"
--     end
--     return "󱉶 " .. table.concat(linters, ", ")
--   end
--   vim.notify(lint_progress())
--   lint.try_lint()
-- end, { desc = "Trigger linting for current file" })
