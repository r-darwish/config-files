return {
  name = "get tickets",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "get-tickets" },
      args = { file },
    }
  end,
}
