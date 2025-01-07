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
      on_highlights = function(hl, c)
        hl.DiagnosticUnnecessary = {
          fg = c.dark3,
        }
      end,
      on_colors = function(colors)
        colors.border = "teal"
        colors.comment = colors.fg_dark
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
