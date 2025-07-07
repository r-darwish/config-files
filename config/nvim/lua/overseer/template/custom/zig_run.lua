---@module 'overseer'

---@type overseer.TemplateFileDefinition
return {
  name = "zig run",
  builder = function()
    ---@type overseer.TaskDefinition
    return {
      cwd = LazyVim.root.get(),
      cmd = { "zig" },
      args = { "build", "run" },
    }
  end,
  condition = {
    filetype = { "zig" },
  },
}