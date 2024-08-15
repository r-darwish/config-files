return {
  {
    "terryma/vim-expand-region",
    keys = {
      { "=", mode = { "n", "x", "o" }, "<Plug>(expand_region_expand)" },
      { "-", mode = { "n", "x", "o" }, "<Plug>(expand_region_shrink)" },
    },
  },
}
