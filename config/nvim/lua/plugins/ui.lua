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
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults.layout_strategy = "flex"
    end,
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
  },
}
