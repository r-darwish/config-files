---Check if linter are running
---@return string
local function lint_checker()
  local linters = require("lint").get_running(vim.fn.bufnr("%"))
  if #linters == 0 then
    return ""
  end
  return string.format("%s 󰑮 %s", "%#Debug#", table.concat(linters, ", "))
end

---@type string?
local _linux_name = nil

---Return the name of the Linux system
---@return string
local function linux_name()
  if vim.fn.has("linux") == 0 then
    return ""
  end

  if _linux_name == nil then
    _linux_name = (function()
      local wsl_distro = os.getenv("WSL_DISTRO_NAME")
      if wsl_distro ~= nil then
        return wsl_distro
      end

      if os.getenv("SSH_CONNECTION") ~= nil then
        local utils = require("darwish.utils")
        local host = utils.read_file("/proc/sys/kernel/hostname")
        return host and utils.strip(host) or ""
      end
    end)()
  end

  return string.format("%s  %s", "%#WarningMsg#", _linux_name)
end

--- Display the git worktree if in one
---@return string
local function worktree_name()
  local worktree = require("darwish.git").worktree()

  if worktree == "" then
    return ""
  end

  return string.format("%s 󰙅 %s", "%#WarningMsg#", worktree)
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
    event = "VeryLazy",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_x, 2)
      table.insert(opts.sections.lualine_x, {
        "overseer",
      })
      table.insert(opts.sections.lualine_x, lint_checker)
      table.insert(opts.sections.lualine_x, lsp_checker)
      table.insert(opts.sections.lualine_x, 1, worktree_name)
      table.insert(opts.sections.lualine_c, 1, linux_name)
      opts.sections.lualine_c[4] = { require("lazyvim.util.lualine").pretty_path({ relative = "root", length = 10 }) }
      table.remove(opts.sections.lualine_c, 5)
      opts.options.section_separators = { left = "", right = "" }
      opts.options.section_separators.component_separators = { left = "", right = "" }
    end,
  },
}
