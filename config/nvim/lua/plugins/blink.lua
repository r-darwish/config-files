return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    local my_opts = {
      enabled = function()
        return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
      end,
      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
      },
    }

    local utils = require("darwish.utils")
    utils.remove_value(opts.sources.default, "copilot")
    utils.remove_value(opts.sources.default, "path")
    opts.sources.providers.copilot = nil
  end,
}
