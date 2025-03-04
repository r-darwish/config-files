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

map({ "n", "x" }, "gh", "^")
map({ "n", "x" }, "gl", "$")
map({ "n" }, "gp", "`[v`]")
map({ "n", "x" }, "q:", "<nop>")
map({ "n", "x" }, "Q", "q")
map({ "x" }, "p", "P")
map({ "n", "x" }, "<f2>", toggle_macro_recording)
map({ "n", "x" }, "<f3>", "@q")
map({ "n", "x" }, "q", "<nop>")
map({ "n", "x", "i" }, "<D-s>", "<C-s>")
map({ "n", "x" }, "<leader>fY", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end, { desc = "Copy absolute path" })

map({ "n", "x" }, "<c-x>", function()
  if (vim.api.nvim_win_get_height(0) / vim.api.nvim_win_get_width(0)) < 0.5 then
    vim.cmd("vsplit")
  else
    vim.cmd("split")
  end
end)

require("snacks.toggle")
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

-- chdir
local function chdir(dir)
  vim.cmd("cd " .. dir)
  vim.notify("Changed directory to " .. dir)
end

local function chdir_file()
  chdir(vim.fn.expand("%:p:h"))
end

local function chdir_root()
  chdir(LazyVim.root.get())
end

local function chdir_git()
  chdir(LazyVim.root.git())
end

vim.api.nvim_create_user_command("ChdirFile", chdir_file, {})
vim.api.nvim_create_user_command("ChdirRoot", chdir_root, {})
vim.api.nvim_create_user_command("ChdirGit", chdir_git, {})
map({ "n", "x" }, "<leader>fdf", chdir_file, { desc = "Change directory to the one of the current file" })
map({ "n", "x" }, "<leader>fdr", chdir_root, { desc = "Change directory to current root directory" })
map({ "n", "x" }, "<leader>fdg", chdir_git, { desc = "Change directory to the git repository of the current file" })

local function git_merge_with_origin()
  local main_branch = require("utils").get_main_branch()

  vim.notify("Fetching repository", "info")
  local root = LazyVim.root.git()
  vim.system({ "git", "fetch" }, { text = true, cwd = root }, function(out)
    if out.code ~= 0 then
      vim.notify("Fetch failed: " .. out.stderr, "error")
    else
      vim.system({ "git", "merge", main_branch }, { text = true, cwd = root }, function(innerOut)
        if innerOut.code ~= 0 then
          vim.notify("Merge failed: " .. innerOut.stderr, "error")
        else
          vim.notify("Merged with " .. main_branch, "info")
        end
      end)
    end
  end)
end

map({ "n", "x" }, "<leader>gm", git_merge_with_origin, { desc = "Merge with origin's main branch" })

local function git_pull()
  local main_branch = require("utils").get_main_branch():gsub("^origin/", "")

  vim.notify("Switching to " .. main_branch .. " and pulling", "info")
  local proc = vim.system({ "git", "switch", "--merge", main_branch }, { text = true, cwd = LazyVim.root.git() }):wait()
  if proc.code ~= 0 then
    vim.notify("Switch failed: " .. proc.stderr, "error")
    return
  end

  vim.system({ "git", "pull", "--rebase", "--autostash" }, { text = true, cwd = LazyVim.root.git() }, function(out)
    if out.code ~= 0 then
      vim.notify("Pull failed: " .. out.stderr, "error")
    else
      vim.notify("Switched to branch " .. main_branch, "info")
    end
  end)
end

map({ "n", "x" }, "<leader>gu", git_pull, { desc = "Switch to the main branch and pull" })

local function open_file_in_same_dir()
  local current_file = vim.fn.expand("%:p:h")
  local file_to_open = vim.fn.input("Enter file name: ", current_file .. "/", "file")
  vim.cmd("edit " .. file_to_open)
end
map({ "n", "v" }, "<leader>fn", open_file_in_same_dir)

local function browse_commit()
  local cwd = LazyVim.root.git() or vim.fn.getcwd()
  local commit = require("utils").extract_quotes(vim.fn.expand("<cWORD>"))
  local proc = vim.system({ "git", "rev-parse", commit }, { text = true, cwd = cwd }):wait()
  if proc.code ~= 0 then
    vim.notify("Bad commit: " .. proc.stderr, "error")
    return
  end

  commit = require("utils").strip(proc.stdout)
  local cmd = { "gh", "browse", commit }
  vim.system(cmd, { cd = cwd })
end
map({ "n", "x" }, "<leader>gx", browse_commit, { desc = "Browse the current commit" })

map("n", "<leader>gf", function()
  Snacks.lazygit.log_file()
end, { desc = "Git Current File History" })

-- Neovide
if vim.g.neovide then
  vim.keymap.set({ "n", "v" }, "<D-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<D-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<D-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")

  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+p') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+p') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>"+pi') -- Paste insert mode
end

-- Copliot
require("snacks.toggle")
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
