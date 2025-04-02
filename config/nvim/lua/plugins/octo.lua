return {
  "pwntester/octo.nvim",
  opts = {
    use_local_fs = true,
    default_merge_method = "squash",
  },
  keys = {
    {
      "<leader>gr",
      function()
        local chdir = require("darwish.chdir")
        chdir.git()
        vim.cmd("Octo review")
      end,
      desc = "Start review",
    },
  },
}
