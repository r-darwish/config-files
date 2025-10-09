local enable_mason = not require("darwish.utils").path_exists("~/.nix-profile")

local app_deps = {
  goimports = "go",
  gofumpt = "go",
  delve = "go",
  gci = "go",
  gotestsum = "go",
  ["golangci-lint"] = "go",
}

--- returns whether an app should be installed
---@param app string
local function should_install(app)
  local dep = app_deps[app]

  return dep == nil or vim.fn.executable(dep) == 1
end

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
    "mason-org/mason.nvim",
    cond = enable_mason,
    opts = function(_, opts)
      for _, app in ipairs({
        "shellcheck",
        "shfmt",
        "bash-language-server",
        "gci",
        "gotestsum",
        "golangci-lint",
      }) do
        table.insert(opts.ensure_installed, app)
      end

      for i, app in ipairs(opts.ensure_installed) do
        if not should_install(app) then
          local last = #opts.ensure_installed
          opts.ensure_installed[i] = opts.ensure_installed[last]
          opts.ensure_installed[last] = nil
        end
      end

      return opts
    end,
  },
}
