local macos = vim.fn.has("macunix") == 1
local paste_key = macos and "<D-v>" or "<S-Insert>"

if macos then
  vim.keymap.set({ "n", "v" }, "<D-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<D-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<D-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
else
  vim.keymap.set({ "n", "v" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end

vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
vim.keymap.set("v", "<D-c>", '"+y') -- Copy
vim.keymap.set("n", paste_key, '"+p') -- Paste normal mode
vim.keymap.set("v", paste_key, '"+p') -- Paste visual mode
vim.keymap.set("c", paste_key, "<C-R>+") -- Paste command mode
vim.keymap.set("i", paste_key, '<ESC>"+pi') -- Paste insert mode
vim.keymap.set("t", paste_key, "<C-\\><C-n>+pi", { noremap = true, silent = true })
