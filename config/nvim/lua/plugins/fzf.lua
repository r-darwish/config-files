return {
  "ibhagwan/fzf-lua",
  keys = {
    {
      "<leader>fs",
      function()
        require("fzf-lua.providers.files").files({ cwd = "~/src" })
      end,
      desc = "Find a source file",
    },
  },
  opts = function(_, opts)
    local my_opts = {
      oldfiles = {
        include_current_session = true,
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100,
        },
      },
      grep = {
        rg_glob = true,
        glob_flag = "--iglob",
        glob_separator = "%s%-%-",
      },
    }

    opts = vim.tbl_deep_extend("force", opts, my_opts)
    return opts
  end,
}
