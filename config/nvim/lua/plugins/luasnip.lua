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

        if value.name == "buffer" then
          value.option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          }
        end
      end

      opts.experimental = {
        ghost_text = nil,
      }
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
        desc = "Search Snippets",
      },
      {
        "<C-v>",
        function()
          require("telescope").extensions.luasnip.luasnip()
        end,
        desc = "Search Snippets",
        mode = { "i" },
      },
    },
  },
}
