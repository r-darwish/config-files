---@module 'overseer'

---@type overseer.TemplateFileDefinition
return {
  name = "zig test file",
  builder = function()
    ---@type overseer.TaskDefinition
    return {
      cwd = LazyVim.root.get(),
      cmd = { "zig" },
      args = { "test", vim.fn.expand("%") },
    }
  end,
  condition = {
    filetype = { "zig" },
  },
}