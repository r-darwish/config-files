return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        yamlls = {
          settings = {
            yaml = { keyOrdering = false },
          },
        },
      },
    },
  },
}
