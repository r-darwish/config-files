return {
  { import = "lazyvim.plugins.extras.coding.luasnip" },
  { import = "lazyvim.plugins.extras.editor.aerial" },
  { import = "lazyvim.plugins.extras.editor.illuminate" },
  { import = "lazyvim.plugins.extras.editor.mini-files" },
  { import = "lazyvim.plugins.extras.editor.navic" },
  { import = "lazyvim.plugins.extras.editor.navic" },
  { import = "lazyvim.plugins.extras.ui.edgy" },
  { import = "lazyvim.plugins.extras.test" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.util.octo" },
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      parents = 2,
    },
  },
  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        width_nofocus = 25,
        width_preview = 100,
      },
    },
    mappings = {
      go_in_plus = "<CR>",
    },
  },
}
