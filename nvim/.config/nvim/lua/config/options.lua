-- =====================================
-- Local to buffer options
-- =====================================
vim.opt.autoindent = true -- copy indent from current line when creating a new line
vim.opt.autoread = true -- file changed outside of vim is updated automatically
vim.opt.background = "dark" -- adjusts the default color groups for that background type.
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "fuzzy", "menu", "menuone", "popup", "noselect" } -- mostly just for cmp
vim.opt.complete = ".,w,b,u,o" -- controls how completion |ins-completion| behaves
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.confirm = true -- if file has been changed and not saved asked to confirm before exiting.
vim.opt.cursorline = true -- highlight the current line
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.foldlevelstart = 99 -- 0 -> all folds closed; 1 -> some folds closed; 99 -> no folds closed.
vim.opt.foldmethod = "syntax" -- the kind of folding strategy used for the current window.
vim.opt.foldminlines = 1
vim.opt.foldnestmax = 5 -- max nesting folds for the "syntax"/"indent" methods.
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns. Use \C to consider case.
vim.opt.inccommand = "split" -- Preview substitutions live as you type!
vim.opt.linebreak = true -- vim'll wrap long line at a character in 'breakat'.
vim.opt.list = true -- helps to see the difference between tabs and spaces, and trailing blanks.
-- vim.opt.listchars = "trail:·,nbsp:␣,tab:→ ,extends:▸,precedes:◂"
vim.opt.listchars = "trail:·,nbsp:␣,tab:  ,extends:▸,precedes:◂"
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.number = true -- set numbered lines
vim.opt.numberwidth = 4 -- set the width of the number column to 4
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.pumborder = "rounded" -- pop up menu height
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.ruler = false -- show the line and column number of the cursor position separated by a coma.
vim.opt.scrolloff = 2 -- sets offset to scroll
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore it's already in the statusline.
vim.opt.showtabline = 0 -- 0: never 1: only if 2 or more 2: always show tabs
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.sidescroll = 1 -- the minimal number or columns to scroll horizontally.
vim.opt.sidescrolloff = 2 -- the minimal number of screen columns to keep to the left/right of the cursor.
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.smarttab = true -- insert `shifwidth` spaces at the beginning of a line (also a BS deletes all spaces simultaneously)
vim.opt.spell = false -- activates spell checking.
vim.opt.spelllang = "en"
-- vim .opt.spelllang = "pt_br"   -- select the language to spell
-- Check available dictionaries in ~/.local/share/nvim/site/spell/
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.termguicolors = true -- set term GUI colors (most terminals support this)
vim.opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 400 -- faster completion (4000ms default)
vim.opt.visualbell = true
vim.opt.winborder = "rounded"
vim.opt.wrap = false -- display lines as one long line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- ===========-- SOLUÇÃO para cursor opaco que esconde o caractere
-- vim.opt.guicursor = {
--   -- Modo Normal: bloco que pisca rapidamente para não esconder o texto
--   -- "n-c:block-nCursor-blinkwait75-blinkon50-blinkoff75",
--   "n-c:hor50-nCursor-blinkwait75-blinkon50-blinkoff75",
--   -- Modo Insert: linha vertical fina (não esconde o caractere)
--   "i:ver25-blinkwait400-blinkon400-blinkoff400",
--   -- Modo Visual: bloco semi-transparente
--   "v:block-blinkwait500-blinkon500-blinkoff500",
--   -- Modo Replace: underline para não esconder
--   "r:hor20-blinkwait200-blinkon200-blinkoff200",
-- }
vim.opt.guicursor = {
  -- "n-v-c:block-blinkwait175-blinkoff150-blinkon175",
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
  "a:blinkwait175-blinkoff150-blinkon175-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

-- ==========================
-- Global options
-- =====================================
vim.g.highlighturl_enabled = true -- highlight URLs by default
vim.g.mapleader = " " -- set leader key
vim.g.maplocalleader = " "

-- =====================================
-- Extra settings
-- =====================================

-- Control length of messages (see manual for other flags).
vim.opt.shortmess:append("c")
-- Don't give ins-completion-menu messages; for		shm-c
-- example, "-- XXX completion (YYY)", "match 1 of 2", "The only
-- match", "Pattern not found", "Back at original", etc.

-- Make the cursor wrap to the next line when reaching the end of a line.
vim.cmd("set whichwrap+=<,>,[,],h,l")
-- Old vim script style: makes foo-bar be treated as a single word.
vim.cmd([[set iskeyword+=-]])
-- Status line related
-- vim.cmd(":hi statusline guibg=NONE")
--

-- Disable builtin plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
