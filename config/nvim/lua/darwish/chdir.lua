local M = {}

---Change directory and notify
---@param dir string
function M.chdir(dir)
  vim.cmd("cd " .. dir)
  vim.autochroot = false
  vim.notify("Changed directory to " .. dir)
end

---Change the directory to the directory of the current file
function M.file()
  M.chdir(vim.fn.expand("%:p:h"))
end

---Change the directory to the root directory of the current file
function M.root()
  M.chdir(LazyVim.root.get())
end

---Change the directory to the git directory of the current file
function M.git()
  M.chdir(LazyVim.root.git())
end

return M
