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

  local utils = require("darwish.utils")

  local proc = vim
    .system(
      { "git", "switch", "--create", name, "--merge", "--no-track", utils.get_main_branch() },
      { cwd = LazyVim.root.git(), text = true }
    )
    :wait()

  if proc.code ~= 0 then
    require("snacks.notify").error("Branch " .. name .. " creation error: " .. proc.stderr)
  end
end
return M
