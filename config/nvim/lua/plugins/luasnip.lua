return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      for _, value in ipairs(opts.sources) do
        if value.name == "luasnip" then
          value.priority = 100
          value.group_index = 1
        end
      end
      vim.print(opts.sources)
    end,
  },
}
