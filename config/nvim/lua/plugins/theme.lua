return {
  {
    "rose-pine/neovim",
    enabled = true,
    name = "rose-pine",
    opts = {
      variant = "moon",
      dark_variant = "moon",
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      dim_inactive = true,
      on_colors = function(colors)
        colors.border = "teal"
      end,
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
