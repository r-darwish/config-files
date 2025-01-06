vim.api.nvim_create_user_command("CopilotSplit", function()
  require("CopilotChat").toggle({ window = { layout = "horizontal", height = 0.3 } })
end, {})

return {
  { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      window = {
        layout = "float",
        width = 0.75,
        height = 0.75,
      },
    },
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
        keymap = {
          next = "<M-]>",
          prev = "<M-[>",
          accept = "<M-l>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = false,
      },
    },
  },
}
