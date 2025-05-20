local M = {}

---Merge the current branch with origin
function M.merge_with_origin()
  local main_branch = M.get_main_branch()

  vim.notify("Fetching repository", "info")
  local root = LazyVim.root.git()
  vim.system({ "git", "fetch" }, { text = true, cwd = root }, function(out)
    if out.code ~= 0 then
      vim.notify("Fetch failed: " .. out.stderr, "error")
    else
      vim.system({ "git", "merge", "--autostash", main_branch }, { text = true, cwd = root }, function(innerOut)
        if innerOut.code ~= 0 then
          vim.notify("Merge failed: " .. innerOut.stderr, "error")
        else
          vim.notify("Merged with " .. main_branch, "info")
        end
      end)
    end
  end)
end

---Pull the current branch
function M.pull()
  local main_branch = M.get_main_branch():gsub("^origin/", "")

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
---@return nil
function M.create_branch_from_origin(name)
  if name == "" then
    return
  end

  local proc = vim
    .system(
      { "git", "switch", "--create", name, "--merge", "--no-track", M.get_main_branch() },
      { cwd = LazyVim.root.git(), text = true }
    )
    :wait()

  if proc.code ~= 0 then
    error("Branch " .. name .. " creation error: " .. proc.stderr)
  end
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

--- Checkout a PR in the given repo path. Git reset hard will be performed
---@param pr string PR number or URL
---@param repo_path string path to the repo
function M.review_pull_request(pr, repo_path)
  local chdir = require("darwish.chdir")

  chdir.chdir(repo_path)
  M.hard_reset(repo_path)
  M.checkout_pr(pr, repo_path)

  vim.cmd("edit " .. repo_path)
  vim.cmd("Octo review")
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

function M.switch_worktree()
  local worktrees = M.worktrees()
  worktrees = vim.tbl_filter(
    ---@param value Worktree
    function(value)
      return not value.current
    end,
    worktrees
  )
  local cwd = LazyVim.root.git() or vim.fn.getcwd()
  local file = vim.fn.expand("%:p"):sub(#cwd + 1)

  if #worktrees == 0 then
    return
  end

  ---@param choice Worktree
  local open = function(choice)
    vim.cmd("edit " .. choice.directory .. file)
  end

  if #worktrees == 1 then
    open(worktrees[1])
  end

  vim.ui.select(worktrees, {
    prompt = "Switch worktree",
    ---@param item Worktree
    format_item = function(item)
      return item.directory
    end,
  }, open)
end

return M
