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
  local selection_start_pos = vim.fn.getpos("v")
  local cusrsor_pos = vim.fn.getpos(".")

  local start_pos = selection_start_pos
  local end_pos = cusrsor_pos
  if
    cusrsor_pos[2] < selection_start_pos[2]
    or (cusrsor_pos[2] == selection_start_pos[2] and cusrsor_pos[3] < selection_start_pos[3])
  then
    start_pos = cusrsor_pos
    end_pos = selection_start_pos
  end

  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  ---@cast lines string[]

  if #lines == 1 then
    return string.sub(lines[1], start_pos[3], end_pos[3])
  else
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3] - 1)
    return table.concat(lines, "\n")
  end
end

---Send the Esc key
function M.esc()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

---Returns whether we're in visual mode
---@return boolean
function M.in_visual_mode()
  return vim.fn.mode() == "v" or vim.fn.mode() == "V"
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

---comment Remove an element from a table
---@generic T
---@param tbl T[]
---@param value T
---@return boolean
function M.remove_value(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      table.remove(tbl, i)
      return true
    end
  end
  return false
end

---@class UserCommandCallbackOpts
---@field name string Command name
---@field args string? The args passed to the command, if any
---@field fargs table? The args split by unescaped whitespace
---@field nargs string? Number of arguments |:command-nargs|
---@field bang boolean? "true" if the command was executed with a ! modifier <bang>
---@field line1 number? The starting line of the command range <line1>
---@field line2 number? The final line of the command range <line2>
---@field range number? The number of items in the command range: 0, 1, or 2 <range>
---@field count number? Any count supplied <count>
---@field reg string? The optional register, if specified <reg>
---@field mods string? Command modifiers, if any <mods>
---@field smods table? Command modifiers in a structured format.

---Create a user command
---@param name string
---@param command string|fun (opts: UserCommandCallbackOpts)
---@param opts vim.api.keyset.user_command
---@return nil
function M.create_command(name, command, opts)
  return vim.api.nvim_create_user_command(name, command, opts)
end

---Check if a path exists, expanding ~ to home directory
---@param path string
---@return boolean
function M.path_exists(path)
  local expanded_path = vim.fn.expand(path)
  return vim.uv.fs_stat(expanded_path) ~= nil
end

---Add a path to the system path if it exists and not already there
---@param path string
function M.add_to_path(path)
  path = vim.fn.expand(path)

  local syspath = os.getenv("PATH")
  if syspath == nil then
    return
  end

  if string.find(syspath, path) then
    return
  end

  if not M.path_exists(path) then
    return
  end

  vim.env.PATH = path .. ":" .. syspath
end

--- Read the content of a file
---@param name string file name
---@return nil | string
function M.read_file(name)
  local file = io.open(name)
  if file == nil then
    return nil
  end

  local content = file:read("*a")
  file:close()

  return content
end

---@class SystemCompletedCo
---@field success boolean
---@field errorObj any?
---@field proc vim.SystemCompleted?
local SystemCompletedCo = {}

function SystemCompletedCo:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function SystemCompletedCo:succeeded()
  return self.proc ~= nil and self.proc.code == 0
end

--- Return an error
---@return string?
function SystemCompletedCo:error()
  return self.success and self.proc.stderr or self.errorObj
end

--- A coroutine version of system
---@param cmd string[]
---@param opts vim.SystemOpts
---@return SystemCompletedCo
function M.system_co(cmd, opts)
  local this = coroutine.running()

  local result = SystemCompletedCo:new()
  assert(this ~= nil, "The result of cb_to_co must be called within a coroutine.")

  result.success, result.errorObj = pcall(vim.system, cmd, opts, function(l_proc)
    result.proc = l_proc
    coroutine.resume(this)
  end)

  if not result.success then
    return result
  end

  coroutine.yield()
  return result
end

---@param co fun(...)
function M.fire(co)
  local success, err = coroutine.resume(coroutine.create(co))
  if not success then
    Snacks.notify.error(err, { title = "Coroutine failed" })
  end
end

--- Turn a coroutine to a callback
---@param co fun(...)
---@return fun()
function M.co_callback(co)
  return function()
    M.fire(co)
  end
end

return M
