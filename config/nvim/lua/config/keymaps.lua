local lazygit = require("snacks.lazygit")
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

-- Quit & Save
map({ "n", "x" }, "<c-c>", "<cmd>:wq<cr>", { desc = "Save and quit" })

-- Tab control
map({ "t" }, "<C-tab>", "<C-\\><C-n>gt")
map({ "n", "x" }, "<C-tab>", "gt")
map({ "t" }, "<C-S-tab>", "<C-\\><C-n>gT")
map({ "n", "x" }, "<C-S-tab>", "gT")
map({ "n", "x" }, "<leader>wb", "<C-w>T", { desc = "Break the current window to a new tab" })

-- Insert/Normal mode toggle
map({ "t" }, "<C-z>", "<C-\\><C-n>")
map({ "t" }, "<C-v>", "<C-\\><C-n>pi")
map({ "n", "x" }, "<C-z>", "i")
map({ "i" }, "<C-z>", "<esc>")

-- Lines
map({ "i", "c" }, "<C-a>", "<Home>")
map({ "i", "c" }, "<C-e>", "<End>")
map({ "n", "x" }, "gh", "^", { desc = "Line start" })
map({ "n", "x" }, "gl", "$", { desc = "Line end" })
map({ "n", "x" }, "Z", "zz", { desc = "Center line" })
map({ "n" }, "k", function()
  return vim.v.count > 0 and "m'" .. vim.v.count .. "k" or "gk"
end, { expr = true })

map({ "n" }, "j", function()
  return vim.v.count > 0 and "m'" .. vim.v.count .. "j" or "gj"
end, { expr = true })

-- Folding
map({ "n", "x" }, "<C-->", "zm", { desc = "Fold more" })
map({ "n", "x" }, "<C-=>", "zr", { desc = "Fold less" })

-- Macros
map({ "n", "x" }, "q:", "<nop>")
map({ "n", "x" }, "Q", "q", { desc = "Record a macro" })
map({ "n", "x" }, "<f2>", toggle_macro_recording)
map({ "n", "x" }, "<f3>", "@q", { desc = "Play macro" })
map({ "n", "x" }, "q", "<nop>")

local utils = require("darwish.utils")
map({ "t" }, "<M-l>", "<C-l>")
map({ "n", "x" }, "<leader>zt", function()
  utils.launch_zellij({ "fish" }, { cwd = vim.fn.expand("%:p:h") })
end, { desc = "Open Zellij at the file's directory" })
map({ "n", "x" }, "<leader>zT", function()
  utils.launch_zellij({ "fish" }, { cwd = LazyVim.root.get() })
end, { desc = "Open Zellij at the project's root" })
map({ "n", "x" }, "<leader>zg", function()
  utils.launch_zellij({ "lazygit" }, { floating = true, cwd = LazyVim.root.get(), name = "lazygit", keep = true })
end, { desc = "Launch Lazygit from zellij" })

map({ "n", "x" }, "<leader>fY", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end, { desc = "Copy absolute path" })

map({ "n", "x" }, "<c-x>", utils.smart_split, { desc = "Smart split" })

map({ "n", "x" }, "<leader>e", function()
  local o = require("oil")
  o.open(o.get_current_dir(0), {})
end, { desc = "Oil" })

local toggle = require("snacks.toggle")

toggle
  .new({
    id = "autochroot",
    name = "Auto Change Directory",
    get = function()
      return vim.autochroot
    end,
    set = function(state)
      vim.autochroot = state
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

-- chdir commands and keys
local chdir = require("darwish.chdir")
vim.api.nvim_create_user_command("ChdirFile", chdir.file, {})
vim.api.nvim_create_user_command("ChdirRoot", chdir.root, {})
vim.api.nvim_create_user_command("ChdirGit", chdir.git, {})
map({ "n", "x" }, "<leader>fdf", chdir.file, { desc = "Change directory to the one of the current file" })
map({ "n", "x" }, "<leader>fdr", chdir.root, { desc = "Change directory to current root directory" })
map({ "n", "x" }, "<leader>fdg", chdir.git, { desc = "Change directory to the git repository of the current file" })

local git = require("darwish.git")
map(
  { "n", "x" },
  "<leader>gm",
  utils.co_callback(git.merge_with_origin_co),
  { desc = "Merge with origin's main branch" }
)
map({ "n", "x" }, "<leader>gu", utils.co_callback(git.pull_co), { desc = "Switch to the main branch and pull" })
map({ "n", "x" }, "<leader>gw", git.switch_worktree, { desc = "Switch worktree" })
map({ "n", "x" }, "<leader>gy", function()
  Snacks.notify.info("Git link copied to the clipboard", { style = "minimal", icon = "" })
  Snacks.gitbrowse({
    open = function(url)
      vim.fn.setreg("+", url)
    end,
    notify = false,
  })
end, { desc = "Git Browse (copy)" })

map({ "n", "x" }, "<leader>cx", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })

local function open_file_in_same_dir()
  local current_file = vim.fn.expand("%:p:h")
  local file_to_open = vim.fn.input("Enter file name: ", current_file .. "/", "file")
  vim.cmd("edit " .. file_to_open)
end
map({ "n", "x" }, "<leader>fn", open_file_in_same_dir, { desc = "Open a file in the same directory" })

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

-- Augment
toggle
  .new({
    id = "augment_auto_trigger",
    name = "Augment Auto Suggestion",
    get = function()
      return not vim.g.augment_disable_completions
    end,
    set = function(state)
      vim.g.augment_disable_completions = not state
    end,
  })
  :map("<leader>at")

-- hlsearch
toggle
  .new({
    id = "hlsearch_trigger",
    name = "Search Highlight",
    get = function()
      return vim.api.nvim_get_option_value("hlsearch", {})
    end,
    set = function(state)
      vim.opt.hlsearch = state
    end,
  })
  :map("<leader>uS")

-- Env vars
vim.api.nvim_create_user_command("SetEnv", function(opts)
  local kv = vim.split(opts.args, "=")

  local env = kv[1]
  local value = #kv == 2 and kv[2] or ""
  vim.fn.setenv(env, value)
end, { nargs = 1 })

vim.api.nvim_create_user_command("GetEnv", function(opts)
  Snacks.debug.inspect(vim.fn.getenv(opts.args))
end, { nargs = 1 })

require("darwish.python")

map({ "x" }, "s", function()
  require("multicursor-nvim").splitCursors()
end)
