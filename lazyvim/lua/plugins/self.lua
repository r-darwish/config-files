return {
  { "ntpeters/vim-better-whitespace" },
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk", "jj" },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
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
