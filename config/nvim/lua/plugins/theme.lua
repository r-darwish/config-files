local transparency = true

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
        transparency = transparency,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      dim_inactive = true,
      transparent = transparency,
      on_highlights = function(hl, c)
        hl.DiagnosticUnnecessary = {
          fg = c.comment,
        }
        hl.CopilotSuggestion = {
          fg = c.magenta2,
          italic = true,
        }
      end,
      on_colors = function(colors)
        colors.border = "teal"
      end,
    },
  },
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_transparent_background = transparency and 2 or 0

      if transparency then
        local function set_normal_float_highlight()
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "FloatTitle", { bg = "NONE" })
        end

        vim.api.nvim_create_autocmd("ColorScheme", {
          pattern = "*",
          callback = set_normal_float_highlight,
        })
      end
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}
