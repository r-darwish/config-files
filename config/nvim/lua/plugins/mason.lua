if os.getenv("TERMUX_VERSION") ~= nil then
  return {}
end

return {
  { import = "lazyvim.plugins.extras.lang.nushell" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.zig" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.helm" },
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
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
