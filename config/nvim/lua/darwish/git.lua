local M = {}

---@type snacks.notifier.Notif.opts
local temp_notif = { id = "pull", icon = "", title = "git", style = "minimal" }
---@type snacks.notifier.Notif.opts
local perm_notif = vim.tbl_extend("force", temp_notif, { timeout = 0 })

---Merge the current branch with origin
function M.merge_with_origin_co()
  local main_branch = M.get_main_branch()
  local utils = require("darwish.utils")

  Snacks.notify.info("Fetching repository", perm_notif)
  local root = LazyVim.root.git()
  local proc = utils.system_co({ "git", "fetch" }, { text = true, cwd = root })

  if not proc:succeeded() then
    Snacks.notify.error("Fetch failed: " .. proc:error(), temp_notif)
    return
  end

  Snacks.notify.info("Merging with " .. main_branch, perm_notif)
  proc = utils.system_co({ "git", "merge", "--autostash", main_branch }, { text = true, cwd = root })
  if not proc:succeeded() then
    Snacks.notify.error("Merge failed: " .. proc:error(), temp_notif)
  else
    Snacks.notify.info("Merged with " .. main_branch, temp_notif)
  end
end

---Pull the current branch
function M.pull_co()
  local main_branch = M.get_main_branch():gsub("^origin/", "")

  local cwd = LazyVim.root.git()
  local utils = require("darwish.utils")

  Snacks.notify.info("Switching to " .. main_branch, perm_notif)
  local proc = utils.system_co({ "git", "switch", "--merge", main_branch }, { text = true, cwd = cwd })
  if not proc:succeeded() then
    Snacks.notify.error("Switch failed: " .. proc:error(), temp_notif)
    return
  end

  Snacks.notify.info("Pulling " .. main_branch, perm_notif)
  proc = utils.system_co({ "git", "pull", "--rebase", "--autostash" }, { text = true, cwd = cwd })
  if not proc:succeeded() then
    Snacks.notify.error("Pull failed: " .. proc:error(), temp_notif)
    return
  end

  Snacks.notify.info("Switched to branch " .. main_branch, temp_notif)
end

---Browse commit at cursor
---@param commit string?
function M.browse_commit(commit)
  local cwd = LazyVim.root.git() or vim.fn.getcwd()

  if commit == nil then
    commit = require("darwish.utils").extract_quotes(vim.fn.expand("<cWORD>"))
  end

  local proc = vim.system({ "git", "rev-parse", commit }, { text = true, cwd = cwd }):wait()
  if proc.code ~= 0 then
    vim.notify("Bad commit: " .. proc.stderr, "error")
    return
  end

  commit = require("darwish.utils").strip(proc.stdout)
  local cmd = { "gh", "browse", commit }
  vim.system(cmd, { cd = cwd })
end

---Get the main git branch
---@param dir string?
---@return string
function M.get_main_branch(dir)
  local result = vim
    .system({ "git", "symbolic-ref", "refs/remotes/origin/HEAD" }, { text = true, cwd = dir or LazyVim.root.git() })
    :wait()
  local main_branch = result.stdout:match("refs/remotes/([%w-_/]+)")
  return main_branch
end

---Create a new branch from origin
---@param name string
---@param worktree string?
---@return nil
function M.create_branch_from_origin_co(name, worktree)
  if name == "" then
    return
  end

  local main_branch = M.get_main_branch()
  local git_root = LazyVim.root.git()

  local utils = require("darwish.utils")
  if worktree ~= nil and not require("darwish.utils").path_exists(worktree) then
    Snacks.notify.info("Creating worktree", perm_notif)
    local proc = utils.system_co({ "git", "worktree", "add", "--detach", worktree }, { cwd = git_root })
    if not proc:succeeded() then
      Snacks.notify.error("Error adding a worktree: " .. proc:error(), temp_notif)
      return
    end
  end

  local cwd = worktree or git_root

  Snacks.notify.info("Creating branch " .. name, perm_notif)
  local proc = utils.system_co(
    { "git", "switch", "--create", name, "--merge", "--no-track", main_branch },
    { cwd = cwd, text = true }
  )

  if not proc:succeeded() then
    Snacks.notify.error("Error creating branch " .. name .. ": " .. proc:error(), temp_notif)
    return
  end

  Snacks.notify.info("Created branch " .. name, temp_notif)
end

--- Perform git reset HEAD --hard
---@param repo_path string Path to the repo
function M.hard_reset(repo_path)
  local proc = vim.system({ "git", "reset", "HEAD", "--hard" }, { cwd = repo_path, text = true }):wait()
  if proc.code ~= 0 then
    error("Git reset failed: " .. proc.stderr)
  end
end

--- Checkout a PR in the given repo path
---@param pr string PR number or URL
---@param repo_path string path to the repo
function M.checkout_pr(pr, repo_path)
  local proc = vim.system({ "gh", "pr", "checkout", pr }, { cwd = repo_path, text = true }):wait()
  if proc.code ~= 0 then
    error("Checkout failed: " .. proc.stderr)
  end
end

--- Checks if we're in a worktree
---@return string the name of the git directory if it's a worktree, otherwise return an empty string
function M.worktree()
  local repo_path = LazyVim.root.git()
  local stat = vim.uv.fs_stat(repo_path .. "/.git")
  if stat == nil then
    return ""
  end

  if stat.type ~= "file" then
    return ""
  end

  local p = require("plenary.path"):new(repo_path)
  return p:make_relative(p:parent().filename)
end

---@class Worktree
---@field directory string
---@field head string
---@field branch string
---@field current boolean

--- Return the list of git workgrees
---@return Worktree[]
function M.worktrees()
  ---@type Worktree[]
  local result = {}
  local worktree = {}

  local cwd = LazyVim.root.git() or vim.fn.getcwd()
  local output = vim.system({ "git", "worktree", "list", "--porcelain" }, { text = true, cwd = cwd }):wait()
  local lines = vim.split(output.stdout, "\n", { trim = true })

  for _, line in ipairs(lines) do
    local parts = vim.split(line, " ", { trim = true })
    if parts[1] == "worktree" then
      worktree.directory = parts[2]
    elseif parts[1] == "HEAD" then
      worktree.head = parts[2]
    elseif parts[1] == "branch" then
      worktree.branch = parts[2]
    elseif parts[1] == "" and worktree.directory ~= nil then
      worktree.current = worktree.directory == cwd
      table.insert(result, worktree)
      worktree = {}
    end
  end

  return result
end

--- Open the current file in another worktree
---@param worktree string
function M.open_in_worktree(worktree)
  local cwd = LazyVim.root.git() or vim.fn.getcwd()
  local pos = vim.api.nvim_win_get_cursor(0)
  local file = vim.fn.expand("%:p"):sub(#cwd + 1)
  vim.cmd("edit " .. worktree .. "/" .. file)
  vim.api.nvim_win_set_cursor(0, pos)
end

--- Show a picker to select another worktree. Open the current file in the selected worktree.
function M.switch_worktree()
  local worktrees = M.worktrees()
  worktrees = vim.tbl_filter(
    ---@param value Worktree
    function(value)
      return not value.current
    end,
    worktrees
  )

  if #worktrees == 0 then
    return
  end

  if #worktrees == 1 then
    M.open_in_worktree(worktrees[1].directory)
    return
  end

  vim.ui.select(
    worktrees,
    {
      prompt = "Switch worktree",
      ---@param item Worktree
      format_item = function(item)
        return item.directory
      end,
    },
    ---@param choice Worktree
    function(choice)
      if choice ~= nil then
        M.open_in_worktree(choice.directory)
      end
    end
  )
end

return M
