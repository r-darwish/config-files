return {
  name = "zig run",
  builder = function()
    return {
      cwd = LazyVim.root.get(),
      cmd = { "zig" },
      args = { "build", "run" },
    }
  end,
  condition = {
    filetype = { "zig" },
  },
}
