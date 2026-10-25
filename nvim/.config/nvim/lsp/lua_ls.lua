---@type vim.lsp.Config

-- Setting up lua-language-server.

-- Is it installed and available?
if not vim.fn.executable("lua-language-server") then
  vim.notify("LSP: lua-language-server not found. Please, install it.", vim.log.levels.WARN)
  return {}
end

-- Add custom config.
local config = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        -- Versão do Lua (LuaJIT para Neovim)
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Reconhecer globais do Neovim
        globals = { "vim", "use" },
      },
      workspace = {
        -- Não perguntar sobre configurações de terceiros
        checkThirdParty = false,
        -- Bibliotecas do Neovim
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
        -- Não analisar arquivos muito grandes
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace",
      },
      -- Configurações específicas para projetos Lua
      hint = {
        enable = true,
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
    },
  },
}

-- Find project root.
config.root_dir = function(_, on_dir)
  local root = vim.fs.dirname(vim.fs.find(config.root_markers, { upward = true })[1])
  if root then
    on_dir(root)
  end
  on_dir(vim.fn.getcwd())
end

return config
