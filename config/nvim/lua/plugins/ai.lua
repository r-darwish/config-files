vim.api.nvim_create_user_command("CopilotSplit", function() end, {})

---@type CopilotChat.config.prompt
local english_prompt = {
  prompt = "Review the following sentences: ",
  system_prompt = "You're an English teacher reviewing the given sentences. Point out any spelling or grammar mistakes. No need to change the phrasing unless the phrasing is very unclear. After explaining all the mistakes, write down the corrected version of the sentence",
  description = "English Review",
  window = { layout = "float" },
}

return {
  {
    "yetone/avante.nvim",
    lazy = true,
    build = "make",
    opts = function(_, opts)
      opts.provider = "copilot"
      opts.file_selector = { provider = "snacks" }

      local api_key_file = vim.fn.expand("~/.tavily")
      if vim.fn.filereadable(api_key_file) == 1 then
        local api_key = vim.fn.readfile(api_key_file)[1]
        if api_key then
          vim.env.TAVILY_API_KEY = api_key
        end
      end
      return opts
    end,
    keys = {
      {
        "<leader>aa",
        function()
          require("avante").toggle_sidebar()
        end,
        desc = "Avante",
      },
    },
  },
  {
    "giuxtaposition/blink-cmp-copilot",
    enabled = false,
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
        English = english_prompt,
      },
    },
    keys = function(_, keys)
      for i, k in ipairs(keys) do
        if k[1] == "<leader>aa" then
          table.remove(keys, i)
          break
        end
      end

      return vim.tbl_extend("force", keys, {
        {
          "<leader>ap",
          function()
            local utils = require("darwish.utils")
            require("CopilotChat").toggle({
              window = { layout = utils.should_split_vertically() and "vertical" or "horizontal", height = 0.4 },
            })
          end,
          desc = "Copilot Chat",
          mode = { "n", "x" },
        },
        {
          "<leader>aP",
          function()
            require("CopilotChat").ask(english_prompt.prompt, english_prompt)
          end,
          desc = "English Review",
          mode = { "n", "x" },
        },
      })
    end,
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
    },
  },
}
