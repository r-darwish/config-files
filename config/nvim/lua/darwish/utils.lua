local M = {}

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

---@param s string
---@return string
function M.strip(s)
  return s:match("^(.-)%s*$")
end

return M
