-- Autocommands group
vim.api.nvim_create_augroup("custom_buffer", { clear = true })

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "custom_buffer",
  pattern = { "qf", "help", "Neotree", "man", "lspinfo", "aerial", "snacks_picker_list" },
  desc = "Use 'q' to quit from common plugins",
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = "custom_buffer",
  desc = "Briefly highlight yanked text",
  callback = function()
    -- vim.hl.on_yank({ higroup = "Visual", timeout = 300 })
    vim.hl.on_yank()
  end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = "custom_buffer",
  desc = "Return to last edit position when opening files",
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec2('silent! normal! g`"zv', {})
  end,
})

-- Autosave
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "FocusLost", "BufLeave" }, {
  group = "custom_buffer",
  desc = "Automatically save modified buffers",
  callback = function(args)
    local bo = vim.bo[args.buf]
    if vim.g.disable_autosave or vim.b[args.buf].disable_autosave then
      return
    end
    -- Only real, named, writable files.
    if bo.buftype ~= "" or not bo.modifiable or bo.readonly or vim.api.nvim_buf_get_name(args.buf) == "" then
      return
    end
    vim.api.nvim_buf_call(args.buf, function()
      vim.cmd("silent! update")
    end)
  end,
})

-- User commands
vim.api.nvim_create_user_command("AutoSaveDisable", function(args)
  if args.bang then
    vim.b.disable_autosave = true
  else
    vim.g.disable_autosave = true
  end
end, {
  desc = "Disable autosave",
  bang = true,
})

vim.api.nvim_create_user_command("AutoSaveEnable", function()
  vim.b.disable_autosave = false
  vim.g.disable_autosave = false
end, {
  desc = "Re-enable autosave",
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

-- ==========================================================
-- Checkout other autocommand definitions in
-- ==========================================================
-- 1) enable_lsp.lua
-- 2) mini.lua
-- 3) which-key.lua
-- 4) nvim-treesitter.lua
-- 5) nvim-lint.lua

-- ==========================================================
-- Checkout user command definitions in
-- ==========================================================
-- 1) plugin_updater.lua
-- ==========================================================
