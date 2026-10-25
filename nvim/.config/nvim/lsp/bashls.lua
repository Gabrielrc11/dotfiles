---@type vim.lsp.Config

---@brief
---
--- https://github.com/bash-lsp/bash-language-server
---
--- `bash-language-server` can be installed via `npm`:
--- ```sh
--- npm i -g bash-language-server
--- ```
---
--- Language server for bash, written using tree sitter in typescript.

-- Check if clangd is install before configuring it.
if not vim.fn.executable("bash-language-server") then
  vim.notify("LSP: bash-langugage-server not found. Please, install it", vim.log.levels.WARN)
  return {}
end

-- See: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/bashls.lua
local config = {
  cmd = { "bash-language-server", "start" },
  settings = {
    bashIde = {
      -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
    },
  },
  filetypes = { "bash", "sh" },
  root_markers = { ".git" },
}

return config
