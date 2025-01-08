local function get_main_branch()
  local result = vim
    .system({ "git", "symbolic-ref", "refs/remotes/origin/HEAD" }, { text = true, cwd = LazyVim.root.git() })
    :wait()
  local main_branch = result.stdout:match("refs/remotes/([%w-_/]+)")
  return main_branch
end

return {
  get_main_branch = get_main_branch,
}
