-- plugins/treesitter.lua
vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

local M = {}

-- =========================================================================
-- nvim-treesitter: apenas gerencia parsers
-- =========================================================================
local function setup_treesitter()
  local ok, ts = pcall(require, "nvim-treesitter.config")
  if not ok then
    vim.notify("nvim-treesitter not found!", vim.log.levels.ERROR)
    return false
  end

  ts.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })

  require("nvim-treesitter").install({
    "c",
    "cpp",
    "lua",
    "vim",
    "vimdoc",
    "latex",
    "bash",
    "rust",
    "markdown",
    "markdown_inline",
    "nix",
    "regex",
  })

  return true
end

-- =========================================================================
-- Highlight e indent: API nativa do Neovim 0.12
-- =========================================================================
-- See: https://neovimcraft.com/plugin/nvim-treesitter/nvim-treesitter/index.html
local function setup_builtin_features()
  vim.api.nvim_create_autocmd("FileType", {
    desc = "Ativa treesitter highlight e indent por filetype",
    callback = function(args)
      -- Ignora se não houver parser disponível para o filetype
      if not pcall(vim.treesitter.start, args.buf) then
        return
      end
      -- Indentation
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

-- =========================================================================
-- nvim-treesitter-textobjects: keymaps explícitos
-- =====================================================================
local function setup_textobjects()
  -- Let us get the subgroups inside nvim-treesitter-textobjects
  local ok, select_module = pcall(require, "nvim-treesitter-textobjects.select")
  if not ok then
    vim.notify("nvim-treesitter-textobjects not found!", vim.log.levels.ERROR)
    return
  end
  -- Other groups are now available
  local swap_module = require("nvim-treesitter-textobjects.swap")
  local move_module = require("nvim-treesitter-textobjects.move")

  -- Disable entire built-in ftplugin mappings to avoid conflicts.
  -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
  vim.g.no_plugin_maps = true

  -- ====================================================================================
  -- Calling setup
  -- ====================================================================================
  require("nvim-treesitter-textobjects").setup({
    select = {
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = "<c-v>", -- blockwise
      },
    },
    move = {
      -- whether to set jumps in the jumplist
      set_jumps = true,
    },
  })

  -- ====================================================================================
  -- SELECTION
  -- ====================================================================================
  local maps = {
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["ac"] = "@class.outer",
    ["ic"] = "@class.inner",
    ["ab"] = "@block.outer",
    ["ib"] = "@block.inner",
    ["ar"] = "@parameter.outer",
    ["ir"] = "@parameter.inner",
    ["a/"] = "@comment.outer",
    ["i/"] = "@comment.inner",
  }

  for key, capture in pairs(maps) do
    vim.keymap.set({ "x", "o" }, key, function()
      select_module.select_textobject(capture, "textobjects")
    end, { desc = "Selecting: " .. capture })
  end
  -- You can also use captures from other query groups like `locals.scm`
  -- NOTE: There is no inner/outer, that's why I mapped the same command to different keybindings.
  vim.keymap.set({ "x", "o" }, "as", function()
    select_module.select_textobject("@local.scope", "locals")
  end, { desc = "Selecting: local [s]cope" })
  vim.keymap.set({ "x", "o" }, "is", function()
    select_module.select_textobject("@local.scope", "locals")
  end, { desc = "Selecting: local [s]cope" })

  -- ====================================================================================
  -- SWAP
  -- ====================================================================================
  -- Parameters swapping
  vim.keymap.set("n", "<leader>a", function()
    swap_module.swap_next "@parameter.inner"
  end, { desc = "Sw[a]p next function parameter" })
  vim.keymap.set("n", "<leader>A", function()
    swap_module.swap_previous "@parameter.outer"
  end, { desc = "Sw[a]p previous function parameter" })

  -- ====================================================================================
  -- MOVE
  -- ====================================================================================
  -- Function begin/end navigation.
  vim.keymap.set({ "n", "x", "o" }, "]m", function()
    move_module.goto_next_start("@function.outer", "textobjects")
  end, { desc = "Go to NEXT function/[m]ethod begin" })
  vim.keymap.set({ "n", "x", "o" }, "[m", function()
    move_module.goto_previous_start("@function.outer", "textobjects")
  end, { desc = "Go to PREV function/[m]ethod begin" })
  vim.keymap.set({ "n", "x", "o" }, "]M", function()
    move_module.goto_next_end("@function.outer", "textobjects")
  end, { desc = "Go to NEXT function/[m]ethod END" })
  vim.keymap.set({ "n", "x", "o" }, "[M", function()
    move_module.goto_previous_end("@function.outer", "textobjects")
  end, { desc = "Go to PREV function/[m]ethod END" })

  -- Moving through LOOPS
  vim.keymap.set({ "n", "x", "o" }, "]o", function()
    move_module.goto_next_start("@loop.outer", "textobjects")
  end, { desc = "Go to NEXT l[o]op BEGIN" })
  vim.keymap.set({ "n", "x", "o" }, "[o", function()
    move_module.goto_previous_start("@loop.outer", "textobjects")
  end, { desc = "Go to PREV l[o]op BEGIN" })
  vim.keymap.set({ "n", "x", "o" }, "]O", function()
    move_module.goto_next_end("@loop.outer", "textobjects")
  end, { desc = "Go to NEXT l[o]op END" })
  vim.keymap.set({ "n", "x", "o" }, "[O", function()
    move_module.goto_previous_end("@loop.outer", "textobjects")
  end, { desc = "Go to PREV l[o]op END" })

  -- Moving to COMMENTS
  vim.keymap.set({ "n", "x", "o" }, "]/", function()
    move_module.goto_next_start("@comment.outer", "textobjects")
  end, { desc = "Go to NEXT comment BEGIN" })
  vim.keymap.set({ "n", "x", "o" }, "[/", function()
    move_module.goto_previous_start("@comment.outer", "textobjects")
  end, { desc = "Go to PREV command BEGIN" })

  -- -- Moving through SCOPE
  -- vim.keymap.set({ "n", "x", "o" }, "]s", function()
  --   move_module.goto_next_start("@local.scope", "locals")
  -- end, { desc = "Go to NEXT [s]cope BEGIN" })
  -- vim.keymap.set({ "n", "x", "o" }, "[s", function()
  --   move_module.goto_previous_start("@local.scope", "locals")
  -- end, { desc = "Go to PREV [s]cope BEGIN" })

  -- Experimental: CLASSES
  vim.keymap.set({ "n", "x", "o" }, "]C", function()
    move_module.goto_next_start("@class.outer", "textobjects")
  end, { desc = "Go to NEXT [c]lass BEGIN" })
  vim.keymap.set({ "n", "x", "o" }, "[C", function()
    move_module.goto_previous_start("@class.outer", "textobjects")
  end, { desc = "Go to PREV [c]lass BEGIN" })
  -- vim.keymap.set({ "n", "x", "o" }, "]C", function()
  --   move_module.goto_previous_end("@class.outer", "textobjects")
  -- end, { desc = "Go to NEXT [c]lass END" })
  -- vim.keymap.set({ "n", "x", "o" }, "[C", function()
  --   move_module.goto_previous_end("@class.outer", "textobjects")
  -- end, { desc = "Go to PREV [c]lass END" })

  -- Repeat navigation commands
  local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
  -- vim way: ; goes to the direction you were moving.
  vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
  vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
  -- Pass on f, F, t, T so that we don't loose the regular behavior of these keys.
  vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
  vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
  vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
  vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
end

-- =========================================================================
-- Bootstrap
-- =========================================================================
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Setup nvim-treesitter e módulos",
  once = true,
  callback = function()
    if setup_treesitter() then
      setup_builtin_features()
      setup_textobjects()
    end
  end,
})

return M
