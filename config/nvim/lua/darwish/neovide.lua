local macos = vim.fn.has("macunix") == 1
local paste_key = macos and "<D-v>" or "<S-Insert>"

if macos then
  vim.keymap.set({ "n", "x" }, "<D-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "x" }, "<D-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "x" }, "<D-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
else
  vim.keymap.set({ "n", "x" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "x" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "x" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end

vim.keymap.set({ "n", "x" }, "<D-t>", "<C-w>T")
vim.keymap.set({ "n", "x" }, "<D-d>", "<C-w>q")
vim.keymap.set({ "n", "x" }, "<D-S-d>", "<cmd>tabclose<CR>")
vim.keymap.set({ "n", "x" }, "<C-tab>", "gt")
vim.keymap.set({ "t" }, "<C-tab>", "<C-\\><C-n>gt")
vim.keymap.set("n", "<D-s>", ":w<CR>")
vim.keymap.set("x", "<D-c>", '"+y')
vim.keymap.set({ "n", "x" }, paste_key, '"+p')
vim.keymap.set({ "c", "i" }, paste_key, "<C-R>+")
vim.keymap.set("t", paste_key, '<C-\\><C-n>"+pi', { noremap = true, silent = true })
