vim.api.nvim_create_user_command("CopilotSplit", function()
  require("CopilotChat").toggle({ window = { layout = "horizontal", height = 0.3 } })
end, {})

local toggle = nil

local function create_toggle()
  if toggle == nil then
    toggle = require("snacks.toggle").new({
      id = "copilot_auto_trigger",
      name = "Copilot Auto Trigger",
      get = function()
        return vim.b.copilot_suggestion_auto_trigger
      end,
      set = function(state)
        vim.b.copilot_suggestion_auto_trigger = state
      end,
    })
  end

  return toggle
end

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
    "zbirenbaum/copilot.lua",
    keys = {
      {
        "<leader>at",
        function()
          create_toggle():toggle()
        end,
      },
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
