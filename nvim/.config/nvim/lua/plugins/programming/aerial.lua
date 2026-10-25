vim.pack.add({ { src = "https://github.com/stevearc/aerial.nvim" } })

local aerial = require("aerial") -- import aerial
-- setup autopairs
aerial.setup({
  -- attach_mode = "global",
  backends = { "lsp", "treesitter", "markdown" },
  show_guides = true,
  filter_kind = false, -- If false display all symbols.
  guides = {
    mid_item = "├ ",
    last_item = "└ ",
  },
  layout = {
    min_width = 28,
    default_direction = "prefer_left",
  },
  keymaps = {
    ["<C-j>"] = false,
    ["<C-k>"] = false,
  },
  on_attach = function(bufnr)
    -- Default: jump forwards/backwards with '{' and '}'
    -- vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { buffer = bufnr, desc = "Jump backwards in Aerial" })
    -- vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { buffer = bufnr, desc = "Jump forwards in Aerial" })
    vim.keymap.set("n", "<leader>ls", "<cmd>AerialToggle<cr>", { buffer = bufnr, desc = "List [s]ymbols" })
  end,
})

-- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
-- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
-- Additionally, if it is a string that matches "actions.<name>",
-- it will use the mapping at require("aerial.actions").<name>
-- Set to `false` to remove a keymap
-- keymaps = {
--   ["?"] = "actions.show_help",
--   ["g?"] = "actions.show_help",
--   ["<CR>"] = "actions.jump",
--   ["<2-LeftMouse>"] = "actions.jump",
--   ["<C-v>"] = "actions.jump_vsplit",
--   ["<C-s>"] = "actions.jump_split",
--   ["p"] = "actions.scroll",
--   ["<C-j>"] = "actions.down_and_scroll",
--   ["<C-k>"] = "actions.up_and_scroll",
--   ["{"] = "actions.prev",
--   ["}"] = "actions.next",
--   ["[["] = "actions.prev_up",
--   ["]]"] = "actions.next_up",
--   ["q"] = "actions.close",
--   ["o"] = "actions.tree_toggle",
--   ["za"] = "actions.tree_toggle",
--   ["O"] = "actions.tree_toggle_recursive",
--   ["zA"] = "actions.tree_toggle_recursive",
--   ["l"] = "actions.tree_open",
--   ["zo"] = "actions.tree_open",
--   ["L"] = "actions.tree_open_recursive",
--   ["zO"] = "actions.tree_open_recursive",
--   ["h"] = "actions.tree_close",
--   ["zc"] = "actions.tree_close",
--   ["H"] = "actions.tree_close_recursive",
--   ["zC"] = "actions.tree_close_recursive",
--   ["zr"] = "actions.tree_increase_fold_level",
--   ["zR"] = "actions.tree_open_all",
--   ["zm"] = "actions.tree_decrease_fold_level",
--   ["zM"] = "actions.tree_close_all",
--   ["zx"] = "actions.tree_sync_folds",
--   ["zX"] = "actions.tree_sync_folds",
-- },
