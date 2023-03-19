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
  {
    "rmagatti/alternate-toggler",
    opts = {
      alternates = {
        ["true"] = "false",
        ["True"] = "False",
        ["TRUE"] = "FALSE",
        ["Yes"] = "No",
        ["YES"] = "NO",
        ["yes"] = "no",
        ["1"] = "0",
        ["&&"] = "||",
        ["and"] = "or",
      },
    },
    keys = {
      {
        "<leader>t",
        function()
          require("alternate-toggler").toggleAlternate()
        end,
        desc = "Toggle Alternate",
      },
    },
  },
}
