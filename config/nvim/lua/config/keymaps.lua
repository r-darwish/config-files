-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

local function toggle_macro_recording()
  if vim.fn.reg_recording() ~= "" then
    vim.cmd("normal! q")
  else
    vim.cmd("normal! qq")
  end
end

map({ "t" }, "<C-z>", "<C-\\><C-n>")
map({ "t" }, "<C-v>", "<C-\\><C-n>pi")
map({ "n", "x" }, "<C-z>", "i")
map({ "i" }, "<C-z>", "<esc>")

map({ "n", "x" }, "gh", "^", { desc = "Line start" })
map({ "n", "x" }, "gl", "$", { desc = "Line end" })
map({ "n" }, "gp", "`[v`]", { desc = "Last paste" })
map({ "n", "x" }, "q:", "<nop>")
map({ "n", "x" }, "Q", "q", { desc = "Record a macro" })
map({ "x" }, "p", "P`]", { desc = "Paste" })
map({ "n" }, "p", "p`]", { desc = "Paste" })
map({ "n", "x" }, "<f2>", toggle_macro_recording)
map({ "n", "x" }, "<f3>", "@q", { desc = "Play macro" })
map({ "n", "x" }, "q", "<nop>")
map({ "n", "x", "i" }, "<D-s>", "<C-s>", { desc = "Save" })
map({ "n", "x" }, "<leader>fY", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end, { desc = "Copy absolute path" })

local utils = require("darwish.utils")
map({ "n", "x" }, "<c-x>", utils.smart_split)

local toggle = require("snacks.toggle")

toggle
  .new({
    id = "autochdir",
    name = "Auto Change Directory",
    get = function()
      return vim.api.nvim_get_option_value("autochdir", {})
    end,
    set = function(state)
      vim.api.nvim_set_option_value("autochdir", state, {})
    end,
  })
  :map("<leader>uc")

map({ "n", "x" }, "<leader>fy", function()
  local root = LazyVim.root.git()
  local path = vim.fn.expand("%:p")

  path = path:gsub(root, "")

  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end, { desc = "Copy absolute path" })

vim.api.nvim_create_user_command("GoLand", function()
  local current_file = vim.fn.expand("%:p")
  vim.fn.system("goland " .. current_file)
end, {})

local chdir = require("darwish.chdir")
vim.api.nvim_create_user_command("ChdirFile", chdir.file, {})
vim.api.nvim_create_user_command("ChdirRoot", chdir.root, {})
vim.api.nvim_create_user_command("ChdirGit", chdir.git, {})
map({ "n", "x" }, "<leader>fdf", chdir.file, { desc = "Change directory to the one of the current file" })
map({ "n", "x" }, "<leader>fdr", chdir.root, { desc = "Change directory to current root directory" })
map({ "n", "x" }, "<leader>fdg", chdir.git, { desc = "Change directory to the git repository of the current file" })

local git = require("darwish.git")
map({ "n", "x" }, "<leader>gm", git.merge_with_origin, { desc = "Merge with origin's main branch" })
map({ "n", "x" }, "<leader>gu", git.pull, { desc = "Switch to the main branch and pull" })

local function open_file_in_same_dir()
  local current_file = vim.fn.expand("%:p:h")
  local file_to_open = vim.fn.input("Enter file name: ", current_file .. "/", "file")
  vim.cmd("edit " .. file_to_open)
end
map({ "n", "x" }, "<leader>fn", open_file_in_same_dir)

map("n", "<leader>gf", function()
  Snacks.lazygit.log_file()
end, { desc = "Git Current File History" })

if vim.g.neovide then
  require("darwish.neovide")
end

require("darwish.go").register_callback("p", function()
  vim.system({ "gh", "pr", "view", "--web" }, { cwd = LazyVim.root.git() }, function(obj)
    if obj.code ~= 0 then
      Snacks.notify.error("Error checking pull request: " .. obj.stderr)
    end
  end)
end, "Browse current pull request")

require("darwish.go").register_callback("c", function(commit)
  git.browse_commit(commit)
end, "Browse commit")

-- Copliot
toggle
  .new({
    id = "copilot_auto_trigger",
    name = "Copilot Auto Suggestion",
    get = function()
      return vim.b.copilot_suggestion_auto_trigger
    end,
    set = function(state)
      vim.b.copilot_suggestion_auto_trigger = state
    end,
  })
  :map("<leader>at")
