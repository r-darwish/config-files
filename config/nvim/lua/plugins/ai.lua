vim.api.nvim_create_user_command("CopilotSplit", function() end, {})

return {
  {
    "giuxtaposition/blink-cmp-copilot",
    enable = false,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot", "folke/snacks.nvim" },
    opts = function(_, opts)
      for i, v in ipairs(opts.sources.default) do
        if v == "copilot" then
          table.remove(opts.sources.default, i)
          break
        end
      end
      opts.sources.providers.copilot = nil
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      {
        "<leader>aa",
        function()
          local utils = require("darwish.utils")
          require("CopilotChat").toggle({
            window = { layout = utils.should_split_vertically() and "vertical" or "horizontal", height = 0.4 },
          })
        end,
        desc = "Copilot Chat",
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    build = nil,
    event = nil,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
          next = "<M-]>",
          prev = "<M-[>",
          accept_word = "<M-w>",
          accept_line = "<M-l>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = false,
      },
    },
  },
}
