return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-buffer" },

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      for _, source in ipairs(opts.sources) do
        if source.name == "buffer" then
          source.option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          }
        end
      end
    end,
  },
}
