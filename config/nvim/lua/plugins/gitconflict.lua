return {
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup({
        highlights = {
          incoming = "@diff.minus",
          current = "@diff.plus",
          ancestor = "@diff.delta",
        },
      })
    end,
    keys = {
      { "<leader>gm", nil, desc = "Git Conflict" },
      { "<leader>gmr", "<cmd>GitConflictRefresh<CR>", desc = "Refresh Git Conflict" },
      { "<leader>gmq", "<cmd>GitConflictListQf<CR>", desc = "Get all conflict to quickfix" },
      { "]x", "<cmd>GitConflictNextConflict<CR>", desc = "Next git conflict" },
      { "[x", "<cmd>GitConflictPrevConflict<CR>", desc = "Previous git conflict" },
      { "<leader>gmb", "<cmd>GitConflictChooseBoth<CR>", desc = "Accept both changes" },
      { "<leader>gmo", "<cmd>GitConflictChooseOurs<CR>", desc = "Accept our changes" },
      { "<leader>gmt", "<cmd>GitConflictChooseTheirs<CR>", desc = "Accept their changes" },
    },
  },
}
