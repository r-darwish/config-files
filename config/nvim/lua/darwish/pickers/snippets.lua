local M = {}

---@class SnippetsPickerConfig : snacks.picker.Config

---@type SnippetsPickerConfig
M.picker = {
  current_file = false,
  source = "snippets",
  preview = "none",
  format = "text",
  layout = {
    preset = "select",
  },
  transform = function(item)
    item.text = item.trigger
    item.ticket = vim.split(item.text, " - ")[1]
  end,
  confirm = "insert",
  actions = {
    insert = function(picker, item)
      if item then
        picker:close()
        local ls = require("luasnip")
        local snip = ls.get_id_snippet(item.trigger)
        ls.snip_expand(snip)
      end
    end,
  },
}

---Pick Snippets
---@return nil
M.pick = function()
  local items = {}
  for _, v in pairs(require("luasnip").available()) do
    for _, snippet in ipairs(v) do
      table.insert(items, snippet)
    end
  end
  local config = { items = items }
  require("snacks.picker").pick(vim.tbl_deep_extend("force", M.picker, config))
end

setmetatable(M, {
  __call = function(_)
    return M.pick()
  end,
})

return M
