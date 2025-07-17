---@module "conform"

return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "fredrikaverpil/neotest-golang",
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          dap_go_enabled = true,
          go_test_args = {
            "-race",
            "-count=1",
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    ---@type conform.setupOpts
    opts = {
      formatters = {
        gci = {
          args = {
            "write",
            "--skip-generated",
            "--skip-vendor",
            "$FILENAME",
            "-s",
            "standard",
            "-s",
            "default",
            "-s",
            "prefix(github.com/wiz-sec/wiz)",
            "-s",
            "prefix(github.com/wiz-sec)",
          },
        },
      },
      formatters_by_ft = {
        go = { "goimports", "gofumpt", "gci" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
      },
    },
  },
}
