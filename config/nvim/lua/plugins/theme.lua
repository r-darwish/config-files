local transparency = false -- os.getenv("TERM") == "xterm-kitty"
local default_theme = "tokyonight"
local theme = os.getenv("NVIM_THEME") or default_theme

vim.opt.cursorline = not transparency

return {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        vim.cmd("colorscheme tokyonight-night")
      end,
      set_light_mode = function()
        vim.cmd("colorscheme tokyonight-day")
      end,
      update_interval = 5000,
      fallback = "dark",
    },
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          dim_inactive = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
        groups = {
          all = {
            SnacksPickerDir = { fg = "palette.orange.dim" },
          },
        },
      })
    end,
  },
  {
    "catppuccin/nvim",
    enabled = false,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    cond = string.find(theme, "rose"),
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
    cond = string.find(theme, "tokyonight"),
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
        hl.AugmentSuggestionHighlight = {
          fg = c.magenta2,
          italic = true,
        }
      end,
      on_colors = function(colors)
        colors.border = "teal"
        colors.comment = colors.fg_dark
      end,
    },
  },
  {
    "sainnhe/gruvbox-material",
    cond = string.find(theme, "gruvbox"),
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_transparent_background = transparency and 2 or 0
      vim.g.gruvbox_material_background = "hard"

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
      colorscheme = theme,
    },
  },
}
