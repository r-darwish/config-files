-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.autochdir = true
vim.opt.gdefault = true
vim.opt.wrap = true
vim.opt.formatoptions:remove({ "r", "o" })
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.titlestring = [[%{v:progname} - %f%h%m%r%w]]
vim.opt.title = true
vim.opt.shada = "'1000,<1000,s100"
vim.opt.cursorline = false
