return {
  {
    "mrcjkb/rustaceanvim",
    cond = vim.fn.executable("rust-analyzer") == 1,
  },
  {
    "nvim-neotest/neotest",
    ---@module "neotest"
    ---@param opts neotest.Config
    opts = function(_, opts)
      if vim.fn.executable("rust-analyzer") == 0 then
        opts.adapters["rustaceanvim.neotest"] = nil
      end
    end,
  },
}
