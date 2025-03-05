---@alias Callback fun (word: string)

local M = {}

local prefix = "go"
vim.keymap.set({ "n", "x" }, prefix, "nop", { desc = "Go somewhere" })

---Normal mode action
---@param callback Callback
---@return fun()
local function n_action(callback)
  return function()
    callback(require("darwish.utils").extract_quotes(vim.fn.expand("<cWORD>")))
  end
end

---Visual mode action
---@param callback Callback
---@return fun()
local function x_action(callback)
  return function()
    callback(require("darwish.utils").get_visual_selection())
  end
end

---Register a callback with the enter key
---@param key string
---@param callback Callback
---@param desc string
function M.register_callback(key, callback, desc)
  local chord = prefix .. key
  vim.keymap.set("n", chord, n_action(callback), { desc = desc })
  vim.keymap.set("x", chord, x_action(callback), { desc = desc })
end

return M
