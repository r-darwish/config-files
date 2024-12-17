-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "n", "x" }, "gh", "^")
map({ "n", "x" }, "gl", "$")
map({ "n", "x" }, "q:", "<nop>")
map({ "n", "x" }, "Q", "q")
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
  local git = require("gitlinker.git")
  local root = git.get_git_root() .. "/"
  local path = vim.fn.expand("%:p")

  path = path:gsub(root, "")

  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end, { desc = "Copy absolute path" })

map({ "n", "x" }, "<c-z>", ":tabedit %<CR>", { desc = "Break the current buffer to a new tab" })

map({ "n", "x" }, "<leader>gT", function()
  local file = vim.fn.expand("%:p:h")
  require("snacks.terminal").open({ "get-tickets", file })
end, { desc = "Get tickets (directory)" })

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
map({ "n", "x" }, "<leader>rf", chdir_file, { desc = "Change directory to the one of the current file" })
map({ "n", "x" }, "<leader>rr", chdir_root, { desc = "Change directory to current root directory" })
map({ "n", "x" }, "<leader>rg", chdir_git, { desc = "Change directory to the git repository of the current file" })
map({ "i" }, "<c-v>", "<cmd>FzfLua registers<cr>", { desc = "Registers" })

local function zoxide()
  require("fzf-lua").fzf_live("zoxide query -l", {
    prompt = false,
    winopts = { title = " Zoxide ", title_pos = "center" },
    actions = {
      ["default"] = function(selected)
        vim.notify(selected[1])
        LazyVim.pick("files", { cwd = selected[1] })()
      end,
      ["ctrl-g"] = function(selected)
        vim.notify(selected[1])
        LazyVim.pick("live_grep", { cwd = selected[1] })()
      end,
    },
  })
end

local function get_tickets(current_file)
  return function()
    local cmd = "get-tickets --raw"
    if current_file then
      cmd = cmd .. " " .. vim.fn.expand("%:p")
    end

    local split = function(t)
      return vim.split(t, " - ")[1]
    end

    require("fzf-lua").fzf_exec(cmd, {
      prompt = false,
      winopts = { title = " Tickets ", title_pos = "center" },
      actions = {
        ["default"] = function(selected)
          vim.fn.setreg("+", split(selected[1]))
        end,
      },
    })
  end
end
map({ "n", "x" }, "<leader>gt", get_tickets(true), { desc = "Get tickets (file)" })
map({ "n", "x" }, "<leader>gT", get_tickets(false), { desc = "Get tickets" })
map({ "n", "x" }, "<leader>fz", zoxide, { desc = "Change directory based on zoxide" })

local function find_plugin()
  LazyVim.pick("files", { cwd = require("lazy.core.config").options.root })()
end
map({ "n", "x" }, "<leader>fp", find_plugin, { desc = "Find plugin" })

map({ "n", "x" }, "<leader>gp", function()
  vim.system({ "gh", "pr", "view", "--web" }, { cwd = LazyVim.root.git() }, nil)
end, { desc = "Open pull request in browser" })

map({ "n", "x" }, "<leader>gP", function()
  require("snacks.terminal").open(
    { "sh", "-c", "gh pr view && gh pr diff" },
    { cwd = LazyVim.root.git(), interactive = false }
  )
end, { desc = "Open pull request" })

map({ "n", "x" }, "<leader>gi", function()
  vim.system({ "nu", "-l", "-c", "circle" }, { cwd = LazyVim.root.git() }, nil)
end, { desc = "Go to CircleCI" })
map(
  { "n", "x" },
  "<leader><space>",
  "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
  { desc = "Switch buffers" }
)

map({ "n", "x" }, "<leader>gb", function()
  require("fzf-lua.providers.git").branches({ cwd = LazyVim.root.git() })
end, {
  desc = "Branches",
})

map({ "n", "x" }, "<leader>gu", "<cmd>!git pull --rebase<CR>", { desc = "Pull" })
