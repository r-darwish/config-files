return {
  {
    "diegoulloao/neofusion.nvim",
    enabled = false,
    opts = {
      transparent_mode = true,
      palette_overrides = {
        gray = "#008DA3",
      },
      overrides = {
        IncSearch = { fg = "#35b5ff" },
      },
    },
  },
  {
    "scottmckendry/cyberdream.nvim",
    opts = {
      transparent = true,
      borderless_telescope = false,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },
}
