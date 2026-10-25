vim.pack.add({ { src = "https://github.com/lewis6991/gitsigns.nvim" } })

local gitsigns = require("gitsigns")
gitsigns.setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },

  preview_config = {
    style = "minimal",
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },

  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "<leader>gj", function()
      gitsigns.nav_hunk("next")
    end, { desc = "[n]ext hunk" })
    map("n", "]h", function()
      gitsigns.nav_hunk("next")
    end, { desc = "[n]ext hunk" })

    map("n", "<leader>gk", function()
      gitsigns.nav_hunk("prev")
    end, { desc = "[p]rev hunk" })
    map("n", "[h", function()
      gitsigns.nav_hunk("prev")
    end, { desc = "[p]rev hunk" })

    -- Actions
    map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[s]tage hunk" })
    map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[S]tage buffer" })
    map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[r]eset hunk" })
    map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "[R]eset buffer" })
    map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "[u]ndo Stage Hunk" })
    map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[p]review hunk" })
    map("n", "<leader>gi", gitsigns.preview_hunk_inline, { desc = "preview hunk [i]nline" })
    map("n", "<leader>gd", gitsigns.diffthis, { desc = "[d]iff index" })
    map("n", "<leader>gl", function()
      gitsigns.blame_line({ full = true })
    end, { desc = "[b]lame line" })
  end,
})
