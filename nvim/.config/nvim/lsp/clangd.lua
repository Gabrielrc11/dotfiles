---@type vim.lsp.Config

-- Setting up clangd

-- Is it installed and available?
if not vim.fn.executable("clangd") == 0 then
  vim.notify("LSP: clangd not found. Please, install it.", vim.log.levels.WARN)
  return {}
end

-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
local function switch_source_header(bufnr, client)
  local method_name = "textDocument/switchSourceHeader"
  ---@diagnostic disable-next-line:param-type-mismatch
  if not client or not client:supports_method(method_name) then
    return vim.notify(("method %s is not supported by any servers active on the current buffer"):format(method_name))
  end
  local params = vim.lsp.util.make_text_document_params(bufnr)
  ---@diagnostic disable-next-line:param-type-mismatch
  client:request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify("corresponding file cannot be determined")
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

-- Add custom config.
local config = {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type", -- obsolete
    "--fallback-style=LLVM", -- Google, LLVM, GNU, Chromium, Microsoft, Mozilla, WebKit
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac", -- AutoTools
    "Makefile",
    "CMakeLists.txt",
    ".git",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
  -- Configuração específica de capabilities para clangd
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
  on_attach = function(client, bufnr)
    -- Special keybinding exclusive clangd.
    vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
      switch_source_header(bufnr, client)
    end, { desc = "Switch between source/header" })
    vim.keymap.set("n", "<leader>lH", "<cmd>LspClangdSwitchSourceHeader<cr>", { desc = "Switch between source/header" })

    -- Enable inlay hints, if available.
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(false)
    end
  end,
}

-- Find project root.
-- config.root_dir = function(_, on_dir)
--   local root = vim.fs.dirname(vim.fs.find(config.root_markers, { upward = true })[1])
--   if root then
--     -- utils.log("Project C/C++ found in: " .. root)
--     on_dir(root)
--   end
--   on_dir(vim.fn.getcwd())
-- end
config.root_dir = function(bufnr, on_dir)
  local name = vim.api.nvim_buf_get_name(bufnr)
  local root = vim.fs.root(name, config.root_markers)
  on_dir(root or vim.fn.getcwd())
end

return config
