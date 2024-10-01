return {
  name = "create pull request",
  builder = function()
    return {
      cmd = { "gh" },
      args = { "pr", "create", "--fill", "--web" },
    }
  end,
}
