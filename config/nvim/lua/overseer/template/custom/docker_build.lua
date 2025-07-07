---@module 'overseer'

---@type overseer.TemplateFileDefinition
return {
  name = "docker build",
  builder = function()
    local dir = vim.fn.expand("%:p:h:t")
    local file = vim.fn.expand("%")
    ---@type overseer.TaskDefinition
    return {
      cmd = { "docker" },
      args = { "build", "-t", dir, ".", "-f", file },
    }
  end,
  condition = {
    filetype = { "dockerfile" },
  },
}