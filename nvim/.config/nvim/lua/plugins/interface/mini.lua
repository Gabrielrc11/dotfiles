-- Collection of various small independent plugins/modules
vim.pack.add({ { src = "https://github.com/echasnovski/mini.nvim", version = "v0.16.0" } })

-- ===============================================================================
require("mini.pairs").setup({})
require("mini.comment").setup({})
require("mini.icons").setup({})
-- require("mini.sessions").setup({ autoread = true })

-- ===============================================================================
local statusline = require("mini.statusline")
-- Set use_icons to true if you have a Nerd Font
statusline.setup({
  use_icons = vim.g.have_nerd_font,
  -- content = {
  --   active = function()
  --     local MiniStatusline = require("mini.statusline")
  --     local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
  --     local git = MiniStatusline.section_git({ trunc_width = 40 })
  --     local diff = MiniStatusline.section_diff({ trunc_width = 75 })
  --     local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
  --     local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
  --
  --     -- Caminho abreviado personalizado
  --     -- local filename = vim.fn.pathshorten(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:."), 1)
  --     local filepath = vim.fn.pathshorten(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:."), 1)
  --     local filename = filepath .. (vim.bo.modified and "[+]" or "") .. (vim.bo.readonly and "[RO]" or "")
  --
  --     local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
  --     local location = MiniStatusline.section_location({ trunc_width = 75 })
  --     local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
  --
  --     return MiniStatusline.combine_groups({
  --       { hl = mode_hl, strings = { mode } },
  --       { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
  --       "%<",
  --       { hl = "MiniStatuslineFilename", strings = { filename } },
  --       "%=",
  --       { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
  --       { hl = mode_hl, strings = { search, location } },
  --     })
  --   end,
  --
  --   -- active = function()
  --   --   local MiniStatusline = require("mini.statusline")
  --   --   local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
  --   --   local git = MiniStatusline.section_git({ trunc_width = 40 })
  --   --   local diff = MiniStatusline.section_diff({ trunc_width = 75 })
  --   --   local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
  --   --   local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
  --   --   local filename = "%t" -- Só o nome do arquivo
  --   --   local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
  --   --   local location = MiniStatusline.section_location({ trunc_width = 75 })
  --   --   local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
  --   --
  --   --   return MiniStatusline.combine_groups({
  --   --     { hl = mode_hl, strings = { mode } },
  --   --     { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
  --   --     "%<",
  --   --     { hl = "MiniStatuslineFilename", strings = { filename } },
  --   --     "%=",
  --   --     { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
  --   --     { hl = mode_hl, strings = { search, location } },
  --   --   })
  --   -- end,
  -- },
})

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return "%2l(%2p%%):%-2v"
end

-- -- Move statusline to the top (winbar).
-- vim.opt.laststatus = 0
-- vim.opt.winbar = "%{%v:lua.MiniStatusline.active()%}"

-- NOTE:
-- Uncomment the setup below only if you choose to run the mini.snppets engine in `blink.cmp`.
--
-- -- ===============================================================================
-- local gen_loader = require('mini.snippets').gen_loader
-- require('mini.snippets').setup({
--   snippets = {
--     -- Load custom file with global snippets first (adjust for Windows)
--     gen_loader.from_file('~/.config/neoslim/snippets/global.json'),
--
--     -- Load snippets based on current language by reading files from
--     -- "snippets/" subdirectories from 'runtimepath' directories.
--     gen_loader.from_lang(),
--   },
-- })

-- -- ===============================================================================
-- -- mini.AI: Better Around/Inside textobjects
-- require("mini.ai").setup({
--   -- Module mappings. Use `''` (empty string) to disable one.
--   mappings = {
--     -- Main textobject prefixes
--     around = "a",
--     inside = "i",
--     -- Next/last variants
--     around_next = "an",
--     inside_next = "in",
--     around_last = "al",
--     inside_last = "il",
--     -- Move cursor to corresponding edge of `a` textobject
--     goto_left = "g[",
--     goto_right = "g]",
--   },
--   -- Number of lines within which textobject is searche
--   n_lines = 500,
-- })

-- ===============================================================================
require("mini.surround").setup({
  -- NOTE: O comportamento padrão do mini.surround é
  -- * `sa(` -> `( texto )`.
  -- * `sa)` -> `(texto)`.
  mappings = {
    -- Module mappings. Use `''` (empty string) to disable one.
    add = "<leader>sa", -- Add surrounding in Normal and Visual modes
    delete = "<leader>sd", -- Delete surrounding
    find = "<leader>sf", -- Find surrounding (to the right)
    find_left = "<leader>sF", -- Find surrounding (to the left)
    -- highlight = "sh", -- Highlight surrounding
    replace = "<leader>sr", -- Replace surrounding
    -- update_n_lines = "<leader>sn", -- Update `n_lines`
    suffix_last = "p", -- Suffix to search with "prev" method
    suffix_next = "n", -- Suffix to search with "next" method
  },
  -- Number of lines within which textobject is searched
  n_lines = 20,
  -- Custom
  custom_surroundings = {
    ["("] = { output = { left = "(", right = ")" } }, -- sem espaço
    [")"] = { output = { left = "( ", right = " )" } }, -- com espaço
    ["["] = { output = { left = "[", right = "]" } },
    ["]"] = { output = { left = "[ ", right = " ]" } },
    ["{"] = { output = { left = "{", right = "}" } },
    ["}"] = { output = { left = "{ ", right = " }" } },
    ["<"] = { output = { left = "<", right = ">" } },
    [">"] = { output = { left = "< ", right = " >" } },
  },
})

-- ===============================================================================
local MiniFiles = require("mini.files")
MiniFiles.setup({
  -- Module mappings created only inside explorer.
  -- Use `''` (empty string) to not create one.
  mappings = {
    -- close = "q",
    close = "<esc>",
    -- go_in = "<CR>",
    go_in = "l",
    go_in_plus = "<ENTER>",
    go_out = "h",
    go_out_plus = "H",
    mark_goto = "'",
    mark_set = "m",
    reset = "<BS>",
    reveal_cwd = "@",
    show_help = "g?",
    synchronize = "<C-S>",
    trim_left = "<",
    trim_right = ">",
  },
  -- Customization of explorer windows
  windows = {
    -- Maximum number of windows to show side by side
    max_number = math.huge,
    -- Whether to show preview of file/directory under cursor
    preview = true,
    -- Width of focused window
    width_focus = 50,
    -- Width of non-focused window
    width_nofocus = 15,
    -- Width of preview window
    width_preview = 75,
  },
})

-- Keybindings
-- vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" }) -- toggle file explorer
vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" }) -- toggle file explorer
vim.keymap.set("n", "<leader>ef", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

-- Added to support smart rename of files.
--
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})
-- ===============================================================================
