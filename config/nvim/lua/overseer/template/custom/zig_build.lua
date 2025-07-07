---@module 'overseer'

---@type overseer.TemplateFileDefinition
return {
  name = "zig build",
  builder = function()
    ---@type overseer.TaskDefinition
    return {
      cwd = LazyVim.root.get(),
      cmd = { "zig" },
      args = { "build" },
    }
  end,
  condition = {
    filetype = { "zig" },
  },
}