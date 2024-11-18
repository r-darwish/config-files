-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.gdefault = true
vim.opt.wrap = true
vim.opt.formatoptions:remove({ "r", "o" })
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.titlestring = [[%{v:progname} - %f%h%m%r%w]]
vim.opt.title = true
vim.opt.shada = "'1000,<1000,s100"
vim.opt.cursorline = false

if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

vim.api.nvim_create_user_command("ChdirFile", function()
  local file_dir = vim.fn.expand("%:p:h")
  vim.cmd("cd " .. file_dir)
end, {})

vim.api.nvim_create_user_command("ChdirRoot", function()
  vim.cmd("cd " .. LazyVim.root.get())
end, {})

vim.api.nvim_create_user_command("ChdirGit", function()
  vim.cmd("cd " .. LazyVim.root.git())
end, {})
