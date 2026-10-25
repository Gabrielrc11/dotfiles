-- Need to add new capabilities to the utility functions that handles LSP
-- see lua.config.lsp_utils.lua

vim.pack.add({
  { src = "https://github.com/kevinhwang91/nvim-ufo" },
  { src = "https://github.com/kevinhwang91/promise-async" },
})

-- Adding number suffix of folded lines instead of the default ellipsis.
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

-- buffer scope handler
-- will override global handler if it is existed
-- local bufnr = vim.api.nvim_get_current_buf()
-- require('ufo').setFoldVirtTextHandler(bufnr, handler)

-- Setup of "ufo"
require("ufo").setup({
  -- treesitter not required
  -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
  -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`-
  provider_selector = function(_, _, _)
    return { "treesitter", "indent" }
  end,
  open_fold_hl_timeout = 0, -- Disable highlight timeout after opening
  -- Some elements in a code of certain file types begin closed.
  close_fold_kinds_for_ft = {
    default = { "imports", "comment" },
    c = { "comment", "region" },
  },
  -- Different preview window to differentiate from regular pop help/completion window.
  preview = {
    win_config = {
      border = { "", "─", "", "", "", "─", "", "" },
      winhighlight = "Normal:Folded",
      winblend = 0,
    },
  },
  -- global handler
  -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
  fold_virt_text_handler = handler,
})

-- buffer setup
vim.o.foldenable = true
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99

-- I prefer the original vim commands to control folding.
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- vim.keymap.set("n", "zR", require("ufo").openAllFolds)
-- vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
-- vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
-- vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
-- Preview keymap
vim.keymap.set("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)
