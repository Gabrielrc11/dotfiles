vim.pack.add({ { src = "https://github.com/folke/snacks.nvim" } })

require("snacks").setup({
  explorer = {
    enabled = true,
  },
  quickfile = {
    enabled = true,
    exclude = { "latex" },
  },
  notifier = { enable = true }, -- pretty `vim.notify`
  input = { enabled = true }, -- better `vim.ui.input`
  statuscolumn = { enabled = true }, -- pretty statuscolumn
  -- scroll = { enable = true }, -- smooth scrolling

  -- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
  picker = {
    enabled = true,
    ui_select = true,
    win = {
      input = {
        keys = {
          ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
          ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
        },
      },
    },
    matchers = {
      frecency = true,
      cwd_bonus = false,
    },
    formatters = {
      file = {
        filename_first = false,
        filename_only = false,
        icon_width = 2,
      },
    },
    layout = {
      -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
      -- override picker layout in keymaps function as a param below
      preset = "telescope", -- defaults to this layout unless overidden
      cycle = true,
    },
    layouts = {
      select = {
        -- preview = false,
        layout = {
          backdrop = false,
          width = 0.6,
          min_width = 80,
          height = 0.4,
          min_height = 10,
          box = "vertical",
          border = "rounded",
          title = "{title}",
          title_pos = "center",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
          { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
        },
      },
      telescope = {
        reverse = false,
        layout = {
          box = "horizontal",
          backdrop = false,
          width = 0.8,
          height = 0.9,
          border = "none",
          {
            box = "vertical",
            -- Change the order of the windows below for search bar to be on top
            {
              win = "input",
              height = 1,
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
            },
            { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
          },
          {
            win = "preview",
            title = "{preview:Preview}",
            width = 0.50,
            border = "rounded",
            title_pos = "center",
          },
        },
      },
      ivy = {
        layout = {
          box = "vertical",
          backdrop = false,
          width = 0,
          height = 0.4,
          position = "bottom",
          border = "top",
          title = " {title} {live} {flags}",
          title_pos = "left",
          { win = "input", height = 1, border = "bottom" },
          {
            box = "horizontal",
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", width = 0.5, border = "left" },
          },
        },
      },
    },
  },
  image = {
    enabled = false,
    doc = {
      float = false,
      inline = true, -- if you want show image on cursor hover
      max_width = 50,
      max_height = 30,
      wo = {
        wrap = true,
      },
    },
    convert = {
      notify = true,
      command = "magick",
    },
    math = {
      enable = true,
    },
  },
})

local Snacks = require("snacks")

-- Pickers
vim.keymap.set("n", "<leader><leader>", function()
  Snacks.picker.buffers({
    layout = "select",
    -- make the picker start in normal mode, rather than insert mode.
    on_show = function()
      vim.cmd.stopinsert()
    end,
    sort_lastused = true,
    current = false,
    win = {
      input = {
        keys = {
          ["dd"] = { "bufdelete", mode = { "n", "i" } },
        },
      },
      list = { keys = { ["dd"] = "bufdelete" } },
    },
  })
end, { desc = "List other open buffers" })

-- Spelling suggestion selection
vim.keymap.set("n", "<leader>ss", function()
  Snacks.picker.spelling({
    layout = "select",
    -- make the picker start in normal mode, rather than insert mode.
    on_show = function()
      vim.cmd.stopinsert()
    end,
  })
end, { desc = "Spelling Suggestions" })

-- Activate File Explorer
vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Open [E]xplor[e]r Snacks" })

-- Rename current file
vim.keymap.set("n", "<leader>rf", function()
  Snacks.rename.rename_file()
end, { desc = "Fast [R]ename Current [F]ile" })

-- -- Activate Zen mode
-- vim.keymap.set("n", "<leader>z", function()
-- 	Snacks.zen()
-- end, { desc = "Activte [Z]en Mode" })

-- Select possible picker from snacks
vim.keymap.set("n", "<leader>fp", function()
  Snacks.picker()
end, { desc = "[p]icker" })

-- List register
vim.keymap.set("n", "<leader>fr", function()
  Snacks.picker.registers()
end, { desc = "[R]egisters" })

-- Grep insided open buffers
vim.keymap.set("n", "<leader>fb", function()
  Snacks.picker.grep_buffers()
end, { desc = "Grep open [B]uffers" })

vim.keymap.set("n", "<leader>/", function()
  Snacks.picker.grep_buffers({
    layout = "select",
    -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
    -- make the picker start in normal mode, rather than insert mode.
    -- on_show = function()
    --   vim.cmd.stopinsert()
    -- end,
  })
end, { desc = "Grep open [B]uffers" })

-- Pick colorschemes available.
vim.keymap.set("n", "<leader>fc", function()
  Snacks.picker.colorschemes({ layout = "ivy" })
end, { desc = "[c]olorschemes" })

-- Pick files
vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "[f]iles" })

-- Grep in all files of workspace.
vim.keymap.set("n", "<leader>fg", function()
  Snacks.picker.grep()
end, { desc = "[g]rep in all files" })

-- Pick help pages
vim.keymap.set("n", "<leader>fh", function()
  Snacks.picker.help()
end, { desc = "[h]elp pages" })

-- Pick keybindings
vim.keymap.set("n", "<leader>fk", function()
  Snacks.picker.keymaps({ layout = "ivy" })
end, { desc = "[k]eymaps" })

-- Select files from neovim tree source.
vim.keymap.set("n", "<leader>fn", function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[n]eovim files" })

-- Pick from list of notifications
vim.keymap.set("n", "<leader>fN", function()
  Snacks.picker.notifications({
    layout = "ivy",
    on_show = function()
      vim.cmd.stopinsert()
    end,
  })
end, { desc = "[N]otifications" })

-- Grep in file from selected word
vim.keymap.set({ "n", "x" }, "<leader>fw", function()
  Snacks.picker.grep_word()
end, { desc = "Search [w]ord selected" })

-- Git
vim.keymap.set("n", "<leader>Gb", function()
  Snacks.picker.git_branches({ layout = "select" })
end, { desc = "Git Branches" })
--
vim.keymap.set("n", "<leader>Gl", function()
  Snacks.picker.git_log()
end, { desc = "Git Log" })

--
vim.keymap.set("n", "<leader>GL", function()
  Snacks.picker.git_log_line()
end, { desc = "Git Log Line" })

vim.keymap.set("n", "<leader>Gs", function()
  Snacks.picker.git_status()
end, { desc = "Git Status" })

vim.keymap.set("n", "<leader>GS", function()
  Snacks.picker.git_stash()
end, { desc = "Git Stash" })

vim.keymap.set("n", "<leader>Gd", function()
  Snacks.picker.git_diff()
end, { desc = "Git Diff (Hunks)" })

vim.keymap.set("n", "<leader>Gf", function()
  Snacks.picker.git_log_file()
end, { desc = "Git Log File" })

-- LSP
vim.keymap.set("n", "<leader>ld", function()
  Snacks.picker.lsp_definitions({ layout = "ivy" })
end, { desc = "Goto [d]efinitions (implementation)" })

vim.keymap.set("n", "<leader>lD", function()
  Snacks.picker.lsp_declarations()
end, { desc = "Goto [D]eclaration" })

vim.keymap.set("n", "<leader>le", function()
  Snacks.picker.diagnostics_buffer({
    layout = "sidebar",
    on_show = function()
      vim.cmd.stopinsert()
    end,
  })
end, { desc = "List [e]rros (diagnostics) of current buffer" })

vim.keymap.set("n", "<leader>lE", function()
  Snacks.picker.diagnostics({
    layout = "sidebar",
    -- make the picker start in normal mode, rather than insert mode.
    on_show = function()
      vim.cmd.stopinsert()
    end,
  })
end, { desc = "List [E]rrors in all files" })

vim.keymap.set("n", "<leader>li", function()
  Snacks.picker.lsp_implementations()
end, { desc = "Goto [i]mplementation" })

vim.keymap.set("n", "<leader>lr", function()
  Snacks.picker.lsp_references({
    on_show = function()
      vim.cmd.stopinsert()
    end,
  })
end, { desc = "List [r]eferences" })

-- vim.keymap.set("n", "<leader>ls", function()
--   Snacks.picker.lsp_symbols({
--     layout = "telescope",
--     -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
--     -- make the picker start in normal mode, rather than insert mode.
--     on_show = function()
--       vim.cmd.stopinsert()
--     end,
--   })
-- end, { desc = "List [S]ymbols" })

vim.keymap.set("n", "<leader>lt", function()
  Snacks.picker.lsp_type_definitions()
end, { desc = "Goto [t]ype Definition" })

vim.keymap.set("n", "<leader>lX", function()
  Snacks.picker.diagnostics({
    on_show = function()
      vim.cmd.stopinsert()
    end,
  })
end, { desc = "[x]-ray diagnostic all files" })

vim.keymap.set("n", "<leader>lx", function()
  Snacks.picker.diagnostics_buffer({
    on_show = function()
      vim.cmd.stopinsert()
    end,
  })
end, { desc = "[x]-ray diagnostic this buffer" })
