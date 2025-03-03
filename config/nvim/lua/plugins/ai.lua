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
          local win = { layout = "horizontal", height = 0.3 }
          if (vim.api.nvim_win_get_height(0) / vim.api.nvim_win_get_width(0)) < 0.5 then
            win = { layout = "vertical", width = 0.3 }
          end
          require("CopilotChat").toggle({ window = win })
        end,
        { desc = "Toggle Copilot" },
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
