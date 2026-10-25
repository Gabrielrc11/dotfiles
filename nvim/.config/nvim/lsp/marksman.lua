---@type vim.lsp.Config
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman

-- Setting up marksman server.

-- Is it installed and available?
if not vim.fn.executable("marksman") then
  vim.notify("LSP: marksman not found. Please, install it.", vim.log.levels.WARN)
  return {}
end

-- Setting up marksman server
local config = {
  cmd = { "marksman", "server" },
  filetypes = { "markdown", "markdown.mdx" },
  root_markers = { ".marksman.toml", ".git" },
}

return config
