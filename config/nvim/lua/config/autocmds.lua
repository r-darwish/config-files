-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- wrap and check for spell in text filetypes

local autocmds = require("darwish.autocmds")

vim.api.nvim_create_autocmd("FileType", {
  group = autocmds.augroup,
  command = "set formatoptions-=cro",
})

autocmds.set_opts({ "lua", "javascript", "terraform", "yaml", "helm", "json" }, { tabstop = 2, shiftwidth = 2 })
autocmds.set_filetype("*.tpl", "helm")
autocmds.set_filetype("*.tf", "terraform")
autocmds.set_filetype(".okta_aws_login_config", "toml")

-- Set the filetype to helm in yaml files that seems like a go template
vim.api.nvim_create_autocmd({
  "BufNewFile",
  "BufRead",
}, {
  pattern = { "*.yaml", "*.yml" },
  group = autocmds.augroup,
  callback = function()
    if vim.fn.search("{{.\\+}}", "nw") ~= 0 then
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_set_option_value("filetype", "helm", { buf = buf })
    end
  end,
})
