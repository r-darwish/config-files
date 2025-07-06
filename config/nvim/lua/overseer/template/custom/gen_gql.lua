---@module 'overseer'

---@type overseer.TemplateFileDefinition
return {
  name = "Generate GQL",
  builder = function()
    ---@type overseer.TaskDefinition
    return {
      cwd = LazyVim.root.get(),
      cmd = { "wz" },
      args = { "task", "gen-gql" },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
