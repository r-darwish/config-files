return {
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_x, 2)
      table.remove(opts.sections.lualine_x, 2)
      table.insert(opts.sections.lualine_x, {
        "overseer",
      })
      table.insert(opts.sections.lualine_x, function()
        local linters = require("lint").get_running()
        if #linters == 0 then
          return ""
        end
        return string.format("%s 󰑮 %s", "%#Orange#", table.concat(linters, ", "))
      end)
      opts.sections.lualine_c[4] = { require("lazyvim.util.lualine").pretty_path({ relative = "root", length = 10 }) }
      opts.options.section_separators = { left = "", right = "" }
      opts.options.section_separators.component_separators = { left = "", right = "" }
    end,
  },
}
