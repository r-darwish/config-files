local function checkout_pr(number)
  vim.fn.chdir(LazyVim.root.git())
  local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  local worktree_dir = vim.fn.input("Enter worktree name", "../" .. dir .. "-pr")
  if worktree_dir == "../" then
    return
  end

  local stat = vim.uv.fs_stat(worktree_dir)
  if not (stat and stat.type == "directory") then
    vim.system({ "git", "worktree", "add", worktree_dir }):wait()
  end

  vim.fn.chdir(worktree_dir)
  vim.system({ "git", "reset", "HEAD", "--hard" }):wait()
  vim.cmd("tabnew")
  local args = {}
  if number then
    args["args"] = number
  end
  require("litee.gh.pr").open_pull(args)
end

return {
  "ldelossa/gh.nvim",
  dependencies = {
    {
      "ldelossa/litee.nvim",
      config = function()
        require("litee.lib").setup()
      end,
    },
  },
  lazy = true,
  cmd = {
    "GHOpenPR",
  },
  keys = {
    {
      "<leader>gp",
      function()
        checkout_pr(vim.fn.input("Enter PR number"))
      end,
      desc = "Open a specifc PR",
    },
    {
      "<leader>gP",
      checkout_pr,
      desc = "Open a PR",
    },
  },
  config = function()
    require("litee.gh").setup()
  end,
}
