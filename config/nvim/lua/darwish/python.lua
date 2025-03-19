local M = {}

---Activate a virtual environment
---@param venv string Path to the virtual environment
function M.activate_venv(venv)
  local path = os.getenv("PATH")
  local venv_bin = venv .. "/bin"
  vim.fn.setenv("PATH", venv_bin .. ":" .. path)
  vim.fn.setenv("VIRTUAL_ENV", venv)
  vim.fn.setenv("VIRTUAL_ENV_PROMPT", vim.fn.expand(venv .. ":p:h"))
  vim.cmd("LspRestart")
end

function M.activate_root()
  M.activate_venv(LazyVim.root.get() .. "/.venv")
end

local utils = require("darwish.utils")

utils.create_command("ActivateVenv", function(opts)
  M.activate_venv(opts.args[1])
end, { nargs = 1, desc = "Activate the given virtual environment" })

utils.create_command("ActivateRootVenv", function(_)
  M.activate_root()
end, { desc = "Activate the virtual environment at the project root" })

return M
