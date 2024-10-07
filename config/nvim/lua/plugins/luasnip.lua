return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      for _, value in ipairs(opts.sources) do
        if value.name == "luasnip" then
          value.priority = 100
          value.group_index = 1
        end
      end
    end,
  },
  {
    "benfowler/telescope-luasnip.nvim",
    keys = {
      {
        "<leader>si",
        function()
          require("telescope").extensions.luasnip.luasnip()
        end,
        desc = "Search snippets",
      },
    },
  },
}
