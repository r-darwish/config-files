return {
  { "lawrence-laz/neotest-zig", tag = "1.3.1", priority = 1000 },
  -- add any tools you want to have installed below
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "shfmt",
        "bash-language-server",
        "golangci-lint",
      },
    },
  },
}
