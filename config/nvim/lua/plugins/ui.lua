return {
  {
    "max397574/better-escape.nvim",
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
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_x, 1)
      table.insert(opts.sections.lualine_x, { "overseer" })
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
