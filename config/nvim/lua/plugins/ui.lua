return {
  {
    "max397574/better-escape.nvim",
    enabled = false,
    opts = {
      mappings = {
        t = {
          j = { k = false },
        },
      },
    },
    config = function(_, opts)
      require("better_escape").setup(opts)
    end,
  },
  {
    "arkav/lualine-lsp-progress",
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_x, 2)
      table.remove(opts.sections.lualine_x, 2)
      table.insert(opts.sections.lualine_x, {
        "overseer",
      })
      table.insert(opts.sections.lualine_x, {
        "lsp_progress",
        colors = {
          use = true,
        },
        spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
      })
      table.insert(opts.sections.lualine_x, function()
        local linters = require("lint").get_running()
        if #linters == 0 then
          return ""
        end
        return string.format("%s 󰑮 %s", "%#Orange#", table.concat(linters, ", "))
      end)
      opts.options.section_separators = { left = "", right = "" }
      opts.options.section_separators.component_separators = { left = "", right = "" }
    end,
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        preview = {
          layout = "vertical",
          vertical = "up:60%",
        },
      },
    },
  },
}
