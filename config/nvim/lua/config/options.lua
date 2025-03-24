-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.wildignorecase = true
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.titlestring = [[%{v:progname} - %f%h%m%r%w]]
vim.opt.title = true
vim.opt.shada = "'1000,<1000,s100"
vim.opt.autochdir = true
vim.opt.relativenumber = false
vim.fn.setenv("EDITOR", "nvim")
vim.g.snacks_animate = false

vim.g.root_spec = {
  {
    "status",
    "config.yml",
    "values.yaml",
    "values.yml",
    ".lazyroot",
    "go.mod",
    "Dockerfile",
    "Taskfile.yaml",
    "Taskfile.yml",
    "README.md",
  },
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

vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h12"
vim.g.neovide_input_use_logo = 1
vim.g.neovide_cursor_trail_size = 0.6
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_particle_density = 10.0
vim.g.neovide_input_macos_option_key_is_meta = "only_left"

if vim.g.neovide then
  pcall(vim.fn.serverstart, vim.fn.stdpath("data") .. "/neovide.sock")
  vim.fn.chdir(vim.fn.expand("~"))
end
