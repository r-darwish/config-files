return {
  {
    "NeogitOrg/neogit",
    config = true,
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit cwd=%:p:h<CR>", desc = "Neogit" },
    },
  },
}
