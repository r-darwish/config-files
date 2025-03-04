local M = {}

M.augroup = vim.api.nvim_create_augroup("darwish", {})

---Register a new autocmd that locally set opts for the given file pattern
---@param pattern string[]
---@param opts { [string]: any }
---@return integer
function M.set_opts(pattern, opts)
  return vim.api.nvim_create_autocmd("FileType", {
    group = M.augroup,
    pattern = pattern,
    callback = function()
      for k, v in pairs(opts) do
        vim.opt_local[k] = v
      end
    end,
  })
end

---Registers an autocmd that sets the file type based on pattern
---@param pattern string
---@param ft string
---@return integer
function M.set_filetype(pattern, ft)
  ---@type vim.api.keyset.create_autocmd.opts
  local args = {
    group = M.augroup,
    pattern = { pattern },
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_set_option_value("filetype", ft, { buf = buf })
    end,
  }

  return vim.api.nvim_create_autocmd({
    "BufNewFile",
    "BufRead",
  }, args)
end

return M
