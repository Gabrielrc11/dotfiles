-- plugins/interface/which-key.lua

-- Add the plugin.
vim.pack.add({ { src = "https://github.com/folke/which-key.nvim" } })

-- The configs
local settings = {
  ---@type false | "classic" | "modern" | "helix"
  preset = "helix",
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- The presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  show_help = true, -- show help message on the command line when the popup is visible
}

-- Função de configuração dos keybindings
local function setup_keybindings()
  local wk = require("which-key")

  -- ========================================================
  -- Special keybindings that do not require description.
  -- --------------------------------------------------------
  -- Disable Space key in normal mode
  vim.keymap.set("", "<Space>", "<Nop>", {})
  -- Create keybindings for inner/around objects between characters
  local chars = { "_", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" }
  for _, char in ipairs(chars) do
    -- Visual mode mappings
    vim.keymap.set("x", "i" .. char, (":<C-u>silent! normal! f%sF%slvt%s<CR>"):format(char, char, char), {})
    vim.keymap.set("x", "a" .. char, (":<C-u>silent! normal! f%sF%svf%s<CR>"):format(char, char, char), {})
    -- Operator-pending mode mappings
    vim.keymap.set("o", "i" .. char, (":<C-u>silent! normal! f%sF%slvt%s<CR>"):format(char, char, char), {})
    vim.keymap.set("o", "a" .. char, (":<C-u>silent! normal! f%sF%svf%s<CR>"):format(char, char, char), {})
  end
  -- Escape from Insertion into Normal mode.
  vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
  vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

  wk.add({
    -- NORMAL mode.
    {
      mode = { "n" },
      -- {
      --   "<leader>a",
      --   function()
      --     require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
      --   end,
      --   desc = "sw[a]p next function parameter",
      -- },
      -- {
      --   "<leader>A",
      --   function()
      --     require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
      --   end,
      --   desc = "sw[a]p previous function parameter",
      -- },
      {
        "<leader>c",
        function()
          if pcall(require, "bufferline") then
            vim.cmd("Bdelete")
          else
            vim.cmd("bdelete")
          end
        end,
        desc = "[c]lose buffer",
      },
      { "<leader>q", "<cmd>q<cr>", desc = "[q]uit window" },
      { "<leader>s", group = "[S]pelling" }, -- group
      {
        name = "Select [S]pelling language",
        { "<leader>Se", "<cmd>setlocal spell spelllang=en<cr>", desc = "[e]nglish [s]pelling" },
        { "<leader>Sp", "<cmd>setlocal spell spelllang=pt<cr>", desc = "[p]ortuguês [s]pelling" },
        { "<leader>Sf", "<cmd>setlocal spell spelllang=fr<cr>", desc = "[f]rançais [s]pelling" },
        -- More spelling keybindings in snacks.lua
      },
      -- Commenting this out to support `ws` (save workspacwe).
      { "<leader>+", "<C-a>", desc = "Increment number on line." },
      { "<leader>-", "<C-x>", desc = "Decrement number on line." },

      -- window management
      {
        name = "[s]plit window",
        { "<leader>sv", "<C-w>v", desc = "split window [v]ertically" }, -- split window vertically
        { "<leader>sh", "<C-w>s", desc = "split window [h]orizontally" }, -- split window horizontally
        { "<leader>s=", "<C-w>=", desc = "Make window splits equal [=] size" }, -- make split windows equal width & height
        { "<leader>sc", "<cmd>close<CR>", desc = "[c]lose current window split" }, -- close current split window
      },

      -- -----------------------------------------------------------------------------------------
      -- GIT related
      -- -----------------------------------------------------------------------------------------
      { "<leader>g", group = "[g]itsigns" }, -- group
      -- Gitsigns keybindings set in gitsigns.lua file.

      -- =====================================================
      -- Snacks picker (finders)
      -- =====================================================
      { "<leader>f", group = "[f]inding" }, -- group
      -- NOTE: Finding keybindings are set in snacks.lua file.

      -- =====================================================
      -- Git related 2 (Snacks)
      -- =====================================================
      { "<leader>G", group = "Snacks [G]it" }, -- group
      -- NOTE: Git related keybindings are set in snacks.lua file.

      -- =====================================================
      -- Workspace (session) Management
      -- =====================================================
      { "<leader>w", group = "[w]orkspaces" }, -- group

      -- =====================================================
      -- LSP related
      -- =====================================================
      { "<leader>l", group = "[l]SP" }, -- group
      -- NOTE: All lsp keybindings are defined in one place: ../../config/enable_lsp.lua
      -- Other LSP related keybindings are set inside aerial.lua and snacks.lua.
      --
      -- ===========================================================

      -- -----------------------------------------------------------------------------------------
      -- Toggle some behaviors on/off
      -- -----------------------------------------------------------------------------------------
      { "<leader>t", group = "[t]toggle on stuff" }, -- group
      -- Toggle buffer line (tabs)
      {
        "<leader>tb",
        function()
          vim.g.bufferline_visible = not vim.g.bufferline_visible
          vim.opt.showtabline = vim.g.bufferline_visible and 2 or 0
          if vim.g.bufferline_visible then
            vim.notify("Bufferline Enabled", vim.log.levels.INFO)
          else
            vim.notify("Bufferline Disabled", vim.log.levels.WARN)
          end
        end,
        desc = "Toggle [b]ufferline",
      },
      -- Toggle LSP diagnostics
      {
        "<leader>tl",
        function()
          -- Adiciona uma função de toggle mais simples seguindo exatamente a documentação
          local bufnr = vim.api.nvim_get_current_buf()
          -- Usa exatamente como sugerido na documentação
          vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
          local status = vim.diagnostic.is_enabled({ bufnr = bufnr }) and "ON" or "OFF"
          vim.notify("LSP diagnostics is " .. status .. " for this buffer", vim.log.levels.INFO)
        end,
        desc = "Toggle [L]SP diagnostics",
      },
      -- Toggle autoformat com <leader>tf
      {
        "<leader>tf",
        function()
          vim.b.disable_autoformat = not vim.b.disable_autoformat
          if vim.b.disable_autoformat then
            vim.notify("Format Disabled", vim.log.levels.WARN)
          else
            vim.notify("Format Enabled", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle auto[f]ormatting",
      },
      -- Toggle signcolumn do gitsigns com <leader>tg
      {
        "<leader>tg",
        function()
          local enabled = require("gitsigns").toggle_signs()
          if enabled then
            vim.notify("Git Signs Enabled", vim.log.levels.INFO)
          else
            vim.notify("Git Signs Disabled", vim.log.levels.WARN)
          end
        end,
        desc = "Toggle [g]it signs",
      },
      -- Toggle wrap
      {
        "<leader>tw",
        function()
          vim.wo.wrap = not vim.wo.wrap
          vim.notify("Wrap " .. (vim.wo.wrap and "Enabled" or "Disabled"))
        end,
        desc = "Toggle [w]rap",
      },
      -- Toggle line numbers
      {
        "<leader>tn",
        function()
          vim.wo.number = not vim.wo.number
          vim.notify("Line Numbers " .. (vim.wo.number and "Enabled" or "Disabled"))
        end,
        desc = "Toggle [n]umbering",
      },
      -- Toggle relative numbers
      {
        "<leader>tr",
        function()
          vim.wo.relativenumber = not vim.wo.relativenumber
          vim.notify("Relative Numbers " .. (vim.wo.relativenumber and "Enabled" or "Disabled"))
        end,
        desc = "Toggle [r]elative numbering",
      },
      -- Toggle diagnostic virtual text
      {
        "<leader>tt",
        function()
          local current = vim.diagnostic.config().virtual_text
          vim.diagnostic.config({ virtual_text = not current })
          vim.notify("Diagnostic Virtual Text " .. (not current and "Enabled" or "Disabled"))
        end,
        desc = "Toggle diagnostic virtual [t]ext",
      },
      {
        "<leader>ts",
        function()
          vim.wo.spell = not vim.wo.spell
          vim.notify("Spell Check " .. (vim.wo.spell and "Enabled" or "Disabled"))
        end,
        desc = "Toggle [s]pelling",
      },

      -- VISUAL mode
      {
        mode = { "v" },
        { "<C-s>", "<C-c><cmd>w!<cr>", desc = "[s]ave current buffer" },
        { "<C-a-s>", "<C-c><cmd>wa!<cr>", desc = "[W]rite [A]ll open buffers to disk" },
        { "<", "<gv", desc = "unindent line" },
        { ">", ">gv", desc = "indent line" },
        -- Maintain the cursor position when yanking a visual selection
        -- http://ddrscott.github.io/blog/2016/yank-without-jank/
        { "y", "myy`y", desc = "yank without moving" },
        { "Y", "myY`y", desc = "yank without moving" },
        -- Paste replace visual selection without copying it
        -- { "p", '"_dP', desc = "Replace visual selection" },
        { "<leader>p", '"_dP', desc = "Replace visual selection" },
        { "<leader>+", "<C-a>", desc = "Increment [+] number on line." },
        { "<leader>-", "<C-x>", desc = "Decrement [-] number on line." },
      },

      -- NORMAL mode withouth <leader>
      {
        mode = { "n" },
        -- Remove highlight from previous search.
        { "<esc>", "<cmd>nohlsearch<cr>", desc = "Turn off highlighted term" },
        -- Navigate buffers
        { "<tab>", "<cmd>bnext<cr>", desc = "Next buffer" },
        { "<right>", "<cmd>bnext<cr>", desc = "Next buffer" },
        { "<s-tab>", "<cmd>bprevious<cr>", desc = "Previous buffer" },
        { "<left>", "<cmd>bprevious<cr>", desc = "Previous buffer" },
        { "=", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "[f]ormat buffer" },

        -- These commands will move the current buffer backwards or forwards in the bufferline
        { "[b", "<CMD>BufferLineMoveNext<CR>", desc = "Move current buffer forwards" },
        { "]b", "<CMD>BufferLineMovePrev<CR>", desc = "Move current buffer backwards" },

        -- Standard Operations
        { "<C-s>", "<cmd>w!<cr>", desc = "[s]ave current buffer" },
        { "<C-A-s>", "<cmd>wa!<cr>", desc = "[W]rite [A]ll open buffers to disk" },
        { "<C-q>", "<cmd>q!<cr>", desc = "Force [q]uit" },
        -- Fix * (Keep the cursor position, don't move to next match)
        {
          "*",
          "*N",
          desc = "Keep the cursor position, don't move to next match",
        },
        -- Fix n and N. Keeping cursor in center
        { "n", "nzzzv", desc = "Move forward but keeping cursor in center" },
        { "N", "Nzzzv", desc = "Move backward but keeping cursor in center" },

        -- Joining lines
        { "J", "mzJ`z", desc = "Joint lines without moving cursor" },

        -- { "<leader>ql", "<CMD> lua vim.diagnostic.setloclist()<cr>", desc = "Show diaggnostics in Quickfix" },
        --

        -- ------------------------------------------------------------------------------------------------
        -- NOTE:
        -- Window and pane navigation are now defined in /home/selan/.config/nvim/after/plugin/herdr_nav.lua
        -- ------------------------------------------------------------------------------------------------

        -- window navigation
        -- { "<C-h>", "<C-w>h", desc = "Move to left split" },
        -- { "<C-j>", "<C-w>j", desc = "Move to below split" },
        -- --  Most Language Servers support renaming across files, etc.
        -- { "<C-k>", "<C-w>k", desc = "Move to above split" },
        -- { "<C-l>", "<C-w>l", desc = "Move to right split" },
        -- { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Move to left pane" },
        -- { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Move to below pane" },
        -- { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Move to above pane" },
        -- { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Move to right pane" },

        -- window resizing
        { "<C-Up>", "<cmd>resize -2<CR>", desc = "Resize split up" },
        { "<C-Down>", "<cmd>resize +2<CR>", desc = "Resize split down" },
        { "<C-Left>", "<cmd>vertical resize -2<CR>", desc = "Resize split left" },
        { "<C-Right>", "<cmd>vertical resize +2<CR>", desc = "Resize split right" },

        -- Centralized half page down/up (from ThePrimeagen)
        { "<C-d>", "<C-d>zz", desc = "Move half page down and center." },
        { "<C-u>", "<C-u>zz", desc = "Move half page up and center." },
        { "<C-f>", "<C-f>zz", desc = "Move full page down and center." },
        { "<C-b>", "<C-b>zz", desc = "Move full page up and center." },

        -- Move buffers around (conflict with tmux A-h/A-l.)
        { "<A-Down>", "<C-w>J", desc = "Move buffer down" },
        { "<A-Up>", "<C-w>K", desc = "Move buffer up" },
        { "<A-Left>", "<C-w>H", desc = "Move buffer left" },
        { "<A-Right>", "<C-w>L", desc = "Move buffer right" },

        -- Another keybinding for maximizing width.
        { "<C-w>\\", "<C-w>|", desc = "Max out the width" },
        { "<C-w>|", "<C-w>_", desc = "Max out the height" },

        -- Easy splits
        { "|", "<CMD>split<cr>", desc = "Horizontal split" },
        { "\\", "<CMD>vsplit<cr>", desc = "Vertical split" },

        -- -- vimimpaired inspired
        -- { "]<space>", "o", desc = "Insert a blank line above" },
        -- { "[<space>", "O", desc = "Insert a blamk line below" },

        -- Move line up and down
        -- { "<A-j>",     ":move .+1<CR>",                     desc = "Move line down" },
        -- { "<A-k>",     ":move .-2<CR>",                     desc = "Move line up" },
        { "<A-j>", "<CMD>cnext<CR>", desc = "Next quickfix entry" },
        { "<A-k>", "<CMD>cprevious<CR>", desc = "Previous quickfix entry" },
        { "<A-J>", "<CMD>lnext<CR>", desc = "Next location entry" },
        { "<A-K>", "<CMD>lprevious<CR>", desc = "Previous location entry" },

        -- Quickfix list navigation
        { "[q", "<CMD>cprevious<CR>", desc = "Previous quickfix entry" },
        { "]q", "<CMD>cnext<CR>", desc = "Next quickfix entry" },
        { "[Q", "<CMD>cfirst<CR>", desc = "First quickfix entry" },
        { "]Q", "<CMD>clast<CR>", desc = "Last quickfix entry" },

        -- location list navigation
        { "[l", "<CMD>lprevious<CR>", desc = "Previous loclist entry" },
        { "]l", "<CMD>lnext<CR>", desc = "Next loclist entry" },
        { "[L", "<CMD>lfirst<CR>", desc = "First loclist entry" },
        { "]L", "<CMD>llast<CR>", desc = "Last loclist entry" },

        -- -- tag list navigation
        -- { "[t", "<CMD>tprevious<CR>", desc = "Previous tag" },
        -- { "]t", "<CMD>tnext<CR>", desc = "Next tag" },
        -- { "[T", "<CMD>tfirst<CR>", desc = "First tag" },
        -- { "]T", "<CMD>tlast<CR>", desc = "Last tag" },

        -- Buffer list navigation
        { "[B", "<CMD>bfirst<CR>", desc = "First buffer" },
        { "]B", "<CMD>blast<CR>", desc = "Last buffer" },
      },

      -- VERTICAL visual block
      {
        -- mappings in Blocks (vertical or otherwise) mode without prefix.
        mode = { "x" },
        -- Move line up and down
        -- { "<A-Down>", ":move '>+1<CR>gv-gv", desc = "move v-block down" },
        -- { "<A-Up>", ":move '<-2<CR>gv-gv", desc = "move v-block up" },
        { "<A-j>", ":move '>+1<CR>gv-gv", desc = "move v-block down" },
        { "<A-k>", ":move '<-2<CR>gv-gv", desc = "move v-block up" },
      },

      -- INSERT mode
      {
        mode = { "i" },
        -- Save buffer.
        { "<C-s>", "<esc><CMD>w!<cr>", desc = "Force [s]ave" },
        { "<C-A-s>", "<esc><cmd>wa!<cr>", desc = "[W]rite [A]ll open buffers to disk" },
      },
    },
  }) -- End of add()
end

-- Função principal de setup
local function setup()
  -- Verificar se o plugin foi carregado
  local ok, wk = pcall(require, "which-key")
  if not ok then
    vim.notify("which-key.nvim not found.", vim.log.levels.ERROR)
    return false
  end
  -- Configurar timeout antes de carregar o which-key
  vim.o.timeout = true
  vim.o.timeoutlen = 300
  -- Setup do which-key com as configurações
  wk.setup(settings)
  -- Configurar os keybindings
  setup_keybindings()

  return true
end

-- This plugin is executed (setup) when nvim is executed.
-- Usando autocmd para garantir que execute após todos os plugins serem carregados
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    setup()
  end,
  once = true,
})
