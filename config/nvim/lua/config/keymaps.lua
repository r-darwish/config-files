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

map({ "n", "x" }, "gh", "^")
map({ "n", "x" }, "gl", "$")
map({ "n" }, "gp", "`[v`]")
map({ "n", "x" }, "q:", "<nop>")
map({ "n", "x" }, "Q", "q")
map({ "n", "x" }, "<f2>", toggle_macro_recording)
map({ "n", "x" }, "<f3>", "@q")
map({ "n", "x" }, "q", "<nop>")
map({ "n", "x" }, "\\", function()
  require("telescope.builtin").buffers()
end)
map({ "n", "x", "i" }, "<D-s>", "<C-s>")
map({ "n", "x", "i" }, "<M-d>", "<cmd>bd<cr>")
map({ "n", "x" }, "<leader>ba", "<cmd>%bd<cr>")

map({ "n", "x" }, "<leader>fY", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end, { desc = "Copy absolute path" })

map({ "n", "x" }, "<leader>fy", function()
  local root = LazyVim.root.git()
  local path = vim.fn.expand("%:p")

  path = path:gsub(root, "")

  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end, { desc = "Copy absolute path" })

map({ "n", "x" }, "<c-z>", ":tabedit %<CR>", { desc = "Break the current buffer to a new tab" })

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

vim.api.nvim_create_user_command("GoLand", function()
  local current_file = vim.fn.expand("%:p")
  vim.fn.system("goland " .. current_file)
end, {})

vim.api.nvim_create_user_command("ChdirFile", chdir_file, {})
vim.api.nvim_create_user_command("ChdirRoot", chdir_root, {})
vim.api.nvim_create_user_command("ChdirGit", chdir_git, {})
map({ "n", "x" }, "<leader>fdf", chdir_file, { desc = "Change directory to the one of the current file" })
map({ "n", "x" }, "<leader>fdr", chdir_root, { desc = "Change directory to current root directory" })
map({ "n", "x" }, "<leader>fdg", chdir_git, { desc = "Change directory to the git repository of the current file" })

map({ "n", "x" }, "<leader>gp", function()
  vim.system({ "gh", "pr", "view", "--web" }, { cwd = LazyVim.root.git() }, nil)
end, { desc = "Open pull request in browser" })

map({ "n", "x" }, "<leader>gP", function()
  require("snacks.terminal").open(
    { "sh", "-c", "gh pr view && gh pr diff" },
    { cwd = LazyVim.root.git(), interactive = false }
  )
end, { desc = "Open pull request" })

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
