-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "n", "x" }, "gh", "^")
map({ "n", "x" }, "gl", "$")
map({ "n", "x" }, "q:", "<nop>")
map({ "n", "x" }, "Q", "q")
map({ "n", "x" }, "q", "<nop>")

map({ "n", "x" }, "<leader>fY", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end, { desc = "Copy absolute path" })

map({ "n", "x" }, "<leader>fy", function()
  local git = require("gitlinker.git")
  local root = git.get_git_root() .. "/"
  local path = vim.fn.expand("%:p")

  path = path:gsub(root, "")

  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end, { desc = "Copy absolute path" })

map({ "n", "x" }, "<c-z>", ":tabedit %<CR>", { desc = "Break the current buffer to a new tab" })

map({ "n", "x" }, "<leader>gt", function()
  local file = vim.fn.expand("%:p")
  LazyVim.Terminal({ "get-tickets", file })
end, { desc = "Get tickets (file)" })

map({ "n", "x" }, "<leader>gT", function()
  local file = vim.fn.expand("%:p:h")
  LazyVim.Terminal({ "get-tickets", file })
end, { desc = "Get tickets (directory)" })
