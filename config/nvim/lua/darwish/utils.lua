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

---Get the visual selection
---@return string
function M.get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  ---@cast lines string[]

  lines[1] = string.sub(lines[1], start_pos[3])
  lines[#lines] = string.sub(lines[#lines], 1, end_pos[3] - 1)

  -- Join the lines into a single string
  return table.concat(lines, "\n")
end

function M.launch_kitty(command)
  local cmd = {
    "kitten",
    "@launch",
    "--hold",
    "--type=tab",
  }
  vim.list_extend(cmd, command)

  vim.system(cmd, nil, function(obj)
    if obj.code ~= 0 then
      vim.notify("Error launching Kitty: " .. obj.stderr, vim.log.levels.ERROR)
    end
  end)
end
return M
