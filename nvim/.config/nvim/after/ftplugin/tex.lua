-- Neovim will run this command when I type the command `:make`.
vim.cmd([[
set makeprg=pdflatex\ -interaction=nonstopmode\ -file-line-error\ %
set errorformat=%f:%l:\ %m
]])

-- Comando para compilar e abrir com Zathura
vim.cmd([[
command! -buffer LatexCompile execute "make" | !zathura %:r.pdf &
]])

-- Mapeamento opcional para o comando
vim.cmd([[
nnoremap <buffer> <leader>cl :LatexCompile<cr>
]])
