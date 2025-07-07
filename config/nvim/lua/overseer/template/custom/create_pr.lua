---@module 'overseer'

---@type overseer.TemplateFileDefinition
return {
  name = "create pull request",
  builder = function()
    ---@type overseer.TaskDefinition
    return {
      cmd = { "gh" },
      args = { "pr", "create", "--fill", "--web" },
    }
  end,
}