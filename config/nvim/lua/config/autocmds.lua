-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("custom", {}),
  pattern = { "lua", "javascript", "terraform", "yaml", "helm", "json" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd({
  "BufNewFile",
  "BufRead",
}, {
  pattern = { "*.yaml", "*.yml", "*.tpl" },
  callback = function()
    if vim.fn.search("{{.\\+}}", "nw") ~= 0 then
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_set_option_value("filetype", "helm", { buf = buf })
    end
  end,
})

vim.api.nvim_create_autocmd({
  "BufNewFile",
  "BufRead",
}, {
  pattern = ".okta_aws_login_config",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_set_option_value("filetype", "confini", { buf = buf })
  end,
})
