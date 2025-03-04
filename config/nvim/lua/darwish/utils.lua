local M = {}

---Extract text in quotes
---@param str string
---@return string
function M.extract_quotes(str)
  local expressions = { [["(.-)"]], [[%'(.-)%']], [[`(.-)`]] }
  for _, exp in ipairs(expressions) do
    local match = string.match(str, exp)
    if match then
      return match
    end
  end

  return str
end

---Strip spaces from a string
---@param s string
---@return string
function M.strip(s)
  return s:match("^(.-)%s*$")
end

---Remove everything from the given remove_suffix
---@param str string string to work on
---@param suffix string match string
---@return string
function M.remove_suffix(str, suffix)
  local pos = string.find(str, suffix)

  if not pos then
    return str
  end

  return string.sub(str, 1, pos - 1)
end

---Returns true if it makes sense to split vertically
---@return boolean
function M.should_split_vertically()
  return (vim.api.nvim_win_get_height(0) / vim.api.nvim_win_get_width(0)) < 0.5
end

---Split in the direction that makes the most sense
function M.smart_split()
  if M.should_split_vertically() then
    vim.cmd("vsplit")
  else
    vim.cmd("split")
  end
end
return M
