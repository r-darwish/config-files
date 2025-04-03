local macos = vim.fn.has("macunix") == 1
local paste_key = macos and "<D-v>" or "<S-Insert>"

--- Change the scale factor
---@param scale_factor number scale factor
local function change_scale(scale_factor)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + scale_factor
end

--- Increase the scale
local function increase_scale()
  change_scale(0.1)
end

--- Decrease the scale
local function decrease_scale()
  change_scale(-0.1)
end

--- Reset the scale
local function reset_scale()
  vim.g.neovide_scale_factor = 1
end

if macos then
  vim.keymap.set({ "n", "x" }, "<D-=>", increase_scale)
  vim.keymap.set({ "n", "x" }, "<D-->", decrease_scale)
  vim.keymap.set({ "n", "x" }, "<D-0>", reset_scale)
else
  vim.keymap.set({ "n", "x" }, "<C-=>", increase_scale)
  vim.keymap.set({ "n", "x" }, "<C-->", decrease_scale)
  vim.keymap.set({ "n", "x" }, "<C-0>", reset_scale)
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
