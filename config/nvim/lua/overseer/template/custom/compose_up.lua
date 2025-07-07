---@module 'overseer'

---@type overseer.TemplateFileDefinition
return {
  name = "docker compose up",
  builder = function()
    ---@type overseer.TaskDefinition
    return {
      cmd = { "docker" },
      args = { "compose", "up", "-d" },
    }
  end,
  condition = {
    callback = function(opts)
      return #vim.fs.find("docker-compose.yml", { upward = true, type = "file", path = opts.dir })[1] > 0
    end,
  },
}

