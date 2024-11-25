return {
  { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },
  {
    "zbirenbaum/copilot.lua",
    build = nil,
    event = nil,
    opts = {
      filetypes = {
        markdown = false
      }
    }
  }
}
