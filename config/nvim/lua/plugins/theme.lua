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
    enabled = false,
    opts = {
      transparent = true,
      borderless_telescope = false,
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
      dark_variant = "moon",
      styles = {
        transparency = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
