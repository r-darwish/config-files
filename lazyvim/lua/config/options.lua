-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.autochdir = true
vim.o.tabstop = 4
vim.o.autowriteall = true
vim.o.gdefault = true

vim.filetype.add({
  filename = {
    [".okta_aws_login_config"] = "ini",
  },
  pattern = {
    [".*/.aws/.*"] = "ini",
  },
})
