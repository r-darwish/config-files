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
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "andersevenrud/cmp-tmux" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "tmux" } }))
    end,
  },
}
