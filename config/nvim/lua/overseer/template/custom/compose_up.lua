return {
  name = "docker compose up",
  builder = function()
    return {
      cmd = { "docker" },
      args = { "compose", "up", "-d" },
    }
  end,
  condition = {
    callback = function(opts)
      return vim.fs.find("docker-compose.yml", { upward = true, type = "file", path = opts.dir })[1]
    end,
  },
}
