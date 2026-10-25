-- Neovim will run this command when I type the command `:make`.
-- This will be valid only for `.cpp` files, i.e. inside C++ project
-- set to compile with `cmake`.
-- You may navigate the any compilation error via quickfix navigation
-- commands: `[q` and `]q`.
vim.cmd([[
set makeprg=cmake\ --build\ build
]])
