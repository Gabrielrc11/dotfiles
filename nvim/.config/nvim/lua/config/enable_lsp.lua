--  Neovim FAQ on LSP:
--
--  Q: How to force-reload LSP?
--  A: Stop all clients, then reload the buffer.
--
-- :lua vim.lsp.stop_client(vim.lsp.get_clients())
-- :edit
--
-- How to list all supported handlers:
-- :lua vim.print(vim.tbl_keys(vim.lsp.handlers))
--
-- To see the capabilities for a given server, try this in a LSP-enabled buffer:
-- :lua vim.lsp.get_clients()[1].server_capabilities
--
-- Note Client:on_attach() is defined for each server config.

-- List of servers to enable.
local servers = {
  "lua_ls",
  "clangd",
  "bashls",
  "marksman",
  "rust_analyzer",
  "texlab",
  "jdtls",
  "rnix",
  -- Add other servers when needed. Need to download config file, though.
  -- 'pyright',
}

-- ===============================================================
-- Some helper functions.
-- ===============================================================

-- Setup global LSP related keybindings.
local function setup_keymaps(ev)
  local bufnr = ev.buf
  local opts = { buffer = bufnr, silent = true }

  -- Formating
  vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, vim.tbl_extend("force", opts, { desc = "[f]ormat buffer" }))
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, vim.tbl_extend("force", opts, { desc = "[f]ormat buffer" }))
  -- Navigation
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to definition" }))
  -- I'm adding this extra keybinding for consistence with the nvim's global keybinds: all of them start with `gr*`.
  vim.keymap.set("n", "grd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to definition" }))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP: Go to declaration" }))
  vim.keymap.set(
    "n",
    "gi",
    vim.lsp.buf.implementation,
    vim.tbl_extend("force", opts, { desc = "LSP: Go to implementation" })
  )
  -- ====================================================================================================================
  -- I'm removing the keybinding below so I start using the original nvim global keymap, which is "grr".
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "LSP: Go to references" }))
  -- ====================================================================================================================
  --These GLOBAL keymaps are created unconditionally when Nvim starts:
  -- - "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
  -- - "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
  -- - "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
  -- - "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
  -- - "grt" is mapped in Normal mode to |vim.lsp.buf.type_definition()|
  -- - "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
  -- - CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
  -- - "an" and "in" are mapped in Visual mode to outer and inner incremental
  --   selections, respectively, using |vim.lsp.buf.selection_range()|
  -- ====================================================================================================================

  -- Information
  vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show [h]elp" }))
  -- Code actions
  vim.keymap.set(
    "n",
    "<leader>la",
    vim.lsp.buf.code_action,
    vim.tbl_extend("force", opts, { desc = "List code [a]ctions" })
  )
  vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Smart re-[n]ame" }))
  vim.keymap.set("n", "<leader>ly", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, vim.tbl_extend("force", opts, { desc = "Smart re-[n]ame" }))
  -- Diagnostics
  vim.keymap.set(
    "n",
    "<leader>ll",
    vim.diagnostic.open_float,
    vim.tbl_extend("force", opts, { desc = "Show [l]ine diagnostic" })
  )
  -- Go to next diagnostic issue
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, vim.tbl_extend("force", opts, { desc = "Goto ] next diagnostic" }))
  -- Go to previous diagnostic issue
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, vim.tbl_extend("force", opts, { desc = "Goto [ previous diagnostic" }))
end
-- End of: local function setup_keymaps(ev)

-- Improves regular capabilities by adding the capabilities provided
-- by the chosen autocomplete engine.
local function base_capabilities_config()
  -- Get the default capabilities.
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Add blink.cmp capabilities, if available.
  local ok_blink, blink = pcall(require, "blink.cmp")
  if ok_blink and blink.get_lsp_capabilities then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  -- Add nvim.ufo (https://github.com/kevinhwang91/nvim-ufo) folding capabilities.
  local ok_ufo, _ = pcall(require, "ufo")
  if ok_ufo then
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
  end
end

-- Customizing the way diagnostics are displayed
local function setup_diagnostics()
  vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    -- underline = { severity = vim.diagnostic.severity.ERROR },
    underline = true,
    virtual_text = {
      spacing = 2,
      source = "if_many",
      prefix = "●",
      -- This (below) controls how to format the error message.
      format = function(diagnostic)
        local prefixes = {
          [vim.diagnostic.severity.ERROR] = "[E] ",
          [vim.diagnostic.severity.WARN] = "[W] ",
          [vim.diagnostic.severity.INFO] = "[I] ",
          [vim.diagnostic.severity.HINT] = "[H] ",
        }
        return (prefixes[diagnostic.severity] or "") .. diagnostic.message
      end,
    },
    -- show signs in the gutter (column area).
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.INFO] = "󰋽 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
      },
    },
    -- Update diagnostics in Insert mode.
    -- 'false' is less annoying...
    update_in_insert = false,
  })
end

-- Define configuration data that are the same for all servers.
local function setup_default_config()
  -- See https://neovim.io/doc/user/lsp.html#lsp-config-merge
  -- The "*" affects all servers.
  vim.lsp.config("*", {
    capabilities = base_capabilities_config(),
    root_markers = { ".git" },
  })
end

-- Customize handlers.
local function setup_lsp_customized_handlers()
  -- NOTE: The customization below is already done globally in options.
  -- Thus, if you comment out these lines, nothing happens.
  -- It's added here only for didatic purposes, to show that it's possible
  -- to customize handlers and how to do it.

  -- Requesting rounded borders.
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = "rounded" })

  -- Requesting rounded borders.
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({ border = "rounded" })
end

-- ===========================[ End of helper function definition ]===========================

-- ---------------------------------------------------------------
-- This is the beginning of the LSP setup process.
-- ---------------------------------------------------------------
-- [1]: [recommended] Keybindings are activated via LspAttach event, below.
-- The keybinding are set in the autocommand defined next.
-- [2]: [optional] Configure the way diagnostics are displayed.
setup_diagnostics()
-- [3]: [optional] Customize the behavior of any LSP handler.
setup_lsp_customized_handlers()
-- [4]: [required] Configure and enable servers.
setup_default_config() -- partial configuration, the rest is done 'per server'.
-- Enable requested servers.
if #servers > 0 then
  vim.lsp.enable(servers)
else
  vim.notify("No LSP server enabled, sorry", vim.log.levels.WARN)
end

-- ========================[ Autocommands Definition ]==================================
-- Configuration of keybindings takes place only when a client is attached.
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup("lsp-attach-group", { clear = true }),
  callback = function(args)
    -- [1]: Setup keybindings associated with native LSP vim commands.
    setup_keymaps(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    -- CTRL-N starts suggestions.
    -- if client:supports_method("textDocument/completion") then
    -- --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    -- end
    -- -- =========================================================================
    -- -- Use code below **only** if you want to rely on omni-complete (C-X,C-O)
    -- -- rather than any external autocomplete plugin, such as `blink`.
    -- -- =========================================================================
    -- if client and client:supports_method("textDocument/completion") then
    --   -- Optional: trigger autocompletion on EVERY keypress. May be slow!
    --   -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
    --   -- client.server_capabilities.completionProvider.triggerCharacters = chars
    --   vim.lsp.completion.enable(true, client.id, args.buf, {
    --     autotrigger = true,
    --     convert = function(item)
    --       return { abbr = item.label:gsub('%b()', '') }
    --     end,
    --   })
    -- end

    -- -- Auto-format ("lint") on save.
    -- -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    -- if client and not client:supports_method('textDocument/willSaveWaitUntil')
    --     and client:supports_method('textDocument/formatting') then
    --   vim.api.nvim_create_autocmd('BufWrite', {
    --     group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
    --     buffer = args.buf,
    --     callback = function()
    --       -- Check first if I toggled on/off formatting manually.
    --       if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
    --         return
    --       end
    --       -- Formattin on save is toggle ON, then proceed.
    --       vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
    --     end,
    --   })
    -- end

    -- =========================================================================
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).rgs.data.client_id)
    -- =========================================================================
    if client and client:supports_method("textDocument/documentHighlight", args.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight-group", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach-group", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "lsp-highlight-group", buffer = event2.buf }
        end,
      })
    end
  end,
})

-- Fechar preview window após completion
vim.api.nvim_create_autocmd("CompleteDone", {
  callback = function()
    vim.cmd("pclose") -- Fecha preview window
  end,
})
-- =====================================================================================
