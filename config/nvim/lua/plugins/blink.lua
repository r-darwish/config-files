---@module "blink.cmp"

return {
  "saghen/blink.cmp",
  ---@param opts blink.cmp.Config
  opts = function(_, opts)
    ---@type blink.cmp.Config
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

    vim.tbl_deep_extend("force", opts, my_opts)
    return opts
  end,
}
