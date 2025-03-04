---@return string
local function get_main_branch()
  local result = vim
    .system({ "git", "symbolic-ref", "refs/remotes/origin/HEAD" }, { text = true, cwd = LazyVim.root.git() })
    :wait()
  local main_branch = result.stdout:match("refs/remotes/([%w-_/]+)")
  return main_branch
end

---@param str string
---@return string
local function extract_quotes(str)
  local expressions = { [["(.-)"]], [[%'(.-)%']], [[`(.-)`]] }
  for _, exp in ipairs(expressions) do
    local match = string.match(str, exp)
    if match then
      return match
    end
  end

  return str
end

---@param s string
---@return string
local function strip(s)
  return s:match("^(.-)%s*$")
end

return {
  get_main_branch = get_main_branch,
  extract_quotes = extract_quotes,
  strip = strip,
}
