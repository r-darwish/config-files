return {
  { "echasnovski/mini.pairs", enabled = false },
  { "ntpeters/vim-better-whitespace" },
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk", "jj" },
    },
  },
  {
    "catppuccin/nvim",
    init = function()
      require("catppuccin").setup({
        transparent_background = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
