if os.getenv("TERMUX_VERSION") ~= nil then
  return {}
end

vim.api.nvim_create_user_command("CopilotSplit", function()
  require("CopilotChat").toggle({ window = { layout = "horizontal", height = 0.3 } })
end, {})

return {
  { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },
  {
    "giuxtaposition/blink-cmp-copilot",
    enable = false,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
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
    "zbirenbaum/copilot.lua",
    keys = {
      { "<leader>at", "<cmd>Copilot toggle<CR>" },
    },
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
