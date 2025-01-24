return {
  name = "zig test file",
  builder = function()
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
