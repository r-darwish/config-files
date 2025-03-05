vim.api.nvim_create_user_command("CopilotSplit", function() end, {})

return {
  {
    "giuxtaposition/blink-cmp-copilot",
    enable = false,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    ---@type CopilotChat.config
    opts = {
      mappings = {
        ---@diagnostic disable-next-line: missing-fields
        reset = {
          normal = "<M-l>",
          insert = "<M-l>",
        },
      },
      prompts = {
        English = {
          prompt = "Review the following paragraph: ",
          system_prompt = "You're an English teacher reviewing the given paragraphs. Point out any spelling or grammar mistakes. No need to change the phrasing unless the phrasing is very unclear. After explaining all the mistakes, write down the corrected version of the sentence",
          description = "English Review",
          mapping = "<leader>ae",
        },
      },
    },
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
