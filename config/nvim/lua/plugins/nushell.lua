return {

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      -- s
    end,
    dependencies = {
      -- NOTE: additional parser
      { "nushell/tree-sitter-nu" },
    },
    -- NOTE: additional parser
    build = ":TSUpdate",
  },
}
