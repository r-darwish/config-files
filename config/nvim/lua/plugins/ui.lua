---Check if linter are running
---@return string
local function lint_checker()
  local linters = require("lint").get_running(vim.fn.bufnr("%"))
  if #linters == 0 then
    return ""
  end
  return string.format("%s 󰑮 %s", "%#Debug#", table.concat(linters, ", "))
end

---Check if the LSP is ready
---@return string
local function lsp_checker()
  return require("darwish.lsprequests").has_pending_requests(vim.fn.bufnr("%"))
      and string.format("%s  LSP", "%#WarningMsg#")
    or ""
end

return {
  { "akinsho/bufferline.nvim", opts = { options = {
    mode = "tabs",
  } } },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_x, 2)
      table.remove(opts.sections.lualine_x, 2)
      table.insert(opts.sections.lualine_x, {
        "overseer",
      })
      table.insert(opts.sections.lualine_x, lint_checker)
      table.insert(opts.sections.lualine_x, lsp_checker)
      opts.sections.lualine_c[4] = { require("lazyvim.util.lualine").pretty_path({ relative = "root", length = 10 }) }
      opts.options.section_separators = { left = "", right = "" }
      opts.options.section_separators.component_separators = { left = "", right = "" }
    end,
  },
}
