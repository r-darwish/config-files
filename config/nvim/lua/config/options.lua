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
vim.g.root_spec = {
  { "values.yaml", "values.yml", ".lazyroot", "go.mod", "Dockerfile", "Taskfile.yaml", "Taskfile.yml" },
  "lsp",
  { ".git", "lua" },
  "cwd",
}
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

if vim.g.neovide then
  vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h14" -- text below applies for VimScript
  vim.g.neovide_input_use_logo = 1

  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
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
