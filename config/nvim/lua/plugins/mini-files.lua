local function directory_exists(path)
  if type(path) == "function" then
    path = path()
  end

  path = vim.fn.expand(path)

  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory"
end

local function set_mark(m, id, path, desc)
  if not directory_exists(path) then
    return
  end
  m.set_bookmark(id, path, { desc = desc })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesExplorerOpen",
  callback = function()
    local m = require("mini.files")
    set_mark(m, "h", "~", "Home directory")
    set_mark(m, "s", "~/src", "Source directory")
    set_mark(m, "w", "~/wiz-sec", "Wiz directory")
    set_mark(m, "g", LazyVim.root.git, "Git directory")
    set_mark(m, "r", LazyVim.root.get, "Root directory")
  end,
})

return {
  {
    "neo-tree.nvim",
    enabled = false,
  },
  {
    "echasnovski/mini.files",
    opts = {
      options = {
        use_as_default_explorer = true,
      },
      windows = {
        width_nofocus = 25,
        width_preview = 100,
      },
      mappings = {
        go_in_plus = "<CR>",
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
      },
    },
  },
}
