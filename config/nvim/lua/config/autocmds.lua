-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- wrap and check for spell in text filetypes

local function set_opts(pattern, opts)
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom", {}),
    pattern = pattern,
    callback = function()
      for k, v in pairs(opts) do
        vim.opt_local[k] = v
      end
    end,
  })
end

local function set_filetype(opts)
  if type(opts.pattern) == "string" then
    opts.pattern = { opts.pattern }
  end

  local args = {}
  if opts.callback ~= nil then
    args.callback = opts.callback
  elseif opts.ft ~= nil then
    args.callback = function()
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_set_option_value("filetype", opts.ft, { buf = buf })
    end
  end
  args.pattern = opts.pattern

  vim.api.nvim_create_autocmd({
    "BufNewFile",
    "BufRead",
  }, args)
end

set_opts({ "lua", "javascript", "terraform", "yaml", "helm", "json" }, { tabstop = 2, shiftwidth = 2 })
set_filetype({ pattern = "*.tpl", ft = "helm" })
set_filetype({ pattern = ".okta_aws_login_config", ft = "toml" })
set_filetype({
  pattern = { "*.yaml", "*.yml" },
  callback = function()
    if vim.fn.search("{{.\\+}}", "nw") ~= 0 then
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_set_option_value("filetype", "helm", { buf = buf })
    end
  end,
})
