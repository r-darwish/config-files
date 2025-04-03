local function review_pr()
  local root = require("lazyvim.util.root").git()
  if root == "" then
    error("Not in a git repository")
  end

  local dir = vim.fn.fnamemodify(root, ":h")
  local repo = dir .. "/" .. vim.fn.fnamemodify(root, ":t") .. "-pr"

  repo = vim.fn.input({ prompt = "Select a working directory", default = repo })
  local pr = vim.fn.input({ prompt = "Select a PR" })
  if pr == "" then
    return
  end

  require("darwish.git").review_pull_request(pr, repo)
end

return {
  "pwntester/octo.nvim",
  opts = {
    use_local_fs = true,
    default_merge_method = "squash",
  },
  keys = {
    {
      "<leader>gr",
      function()
        local chdir = require("darwish.chdir")
        chdir.git()
        vim.cmd("Octo review")
      end,
      desc = "Start review",
    },
    {
      "<leader>gR",
      review_pr,
    },
  },
}
