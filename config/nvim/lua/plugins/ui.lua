return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_x, 1)
      opts.options = {
        section_separators = "",
        component_separators = "",
      }
    end,
  },
}
