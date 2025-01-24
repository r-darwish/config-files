return {
  name = "zig build",
  builder = function()
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
