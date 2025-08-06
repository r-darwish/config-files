local enable_mason = not require("darwish.utils").path_exists("~/.nix-profile")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    cond = enable_mason,
  },
  {
    "williamboman/mason.nvim",
    cond = enable_mason,
    opts = {
      ensure_installed = {
        "shellcheck",
        "shfmt",
        "bash-language-server",
        "gci",
        "fish-lsp",
      },
    },
  },
}
