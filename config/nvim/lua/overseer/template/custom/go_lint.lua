---@module 'overseer'

---@type overseer.TemplateFileDefinition
return {
  name = "Lint with golangci-lint",
  builder = function()
    ---@type overseer.TaskDefinition
    return {
      cwd = LazyVim.root.get(),
      cmd = { vim.fn.expand("~/go/bin/golangci-lint") },
      args = { "run", "--timeout", "15m" },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
