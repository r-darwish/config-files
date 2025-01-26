local function zoxide()
  require("fzf-lua").fzf_live("zoxide query -l", {
    prompt = false,
    winopts = { title = " Zoxide ", title_pos = "center" },
    actions = {
      ["default"] = function(selected)
        LazyVim.pick("files", { cwd = selected[1] })()
      end,
      ["ctrl-s"] = function(selected)
        LazyVim.pick("live_grep", { cwd = selected[1] })()
      end,
      ["ctrl-l"] = function(selected)
        require("snacks.lazygit").open({ cwd = selected[1] })
      end,
    },
  })
end

local function find_plugin()
  LazyVim.pick("files", { cwd = require("lazy.core.config").options.root })()
end

local function goto_circle(selected)
  vim.system({ "nu", "-l", "-c", "circle -b " .. selected[1]:sub(2) }, { cwd = LazyVim.root.git() }, nil)
end

local function goto_github(selected)
  vim.system({ "gh", "pr", "view", "--web", vim.trim(selected[1]:sub(2)) }, { cwd = LazyVim.root.git() }, nil)
end

return {
  "ibhagwan/fzf-lua",
  keys = {
    {
      "<leader>fg",
      function()
        require("fzf-lua.providers.git").files({ cwd = LazyVim.root.git() })
      end,
      desc = "Find Files (git-files)",
    },
    {
      "<leader>fc",
      function()
        local config_dir = vim.fn.stdpath("config")
        require("fzf-lua.providers.git").files({ cwd = config_dir })
      end,
      desc = "Find a config file",
    },
    {
      "<leader>fs",
      function()
        require("fzf-lua.providers.files").files({ cwd = "~/src" })
      end,
      desc = "Find a source file",
    },
    {
      "<leader>gc",
      function()
        require("fzf-lua.providers.git").commits({ cwd = LazyVim.root.git() })
      end,
      desc = "Commits",
    },
    {
      "<leader>gs",
      function()
        require("fzf-lua.providers.git").status({ cwd = LazyVim.root.git() })
      end,
      desc = "Status",
    },
    { "<leader>fz", zoxide, desc = "Change directory based on zoxide" },
    { "<leader>fp", find_plugin, desc = "Find plugin" },
    { "<c-v>", "<cmd>FzfLua registers<cr>", mode = { "i" }, desc = "Registers" },
    { "<leader>sl", "<cmd>FzfLua lines<cr>", desc = "Lines" },
    { "<leader>s;", "<cmd>FzfLua changes<cr>", desc = "Changes" },
    { "<leader>gC", "<cmd>FzfLua git_bcommits<cr>", desc = "Buffer commits" },
    {
      "<leader>gb",
      function()
        require("fzf-lua.providers.git").branches({
          cwd = LazyVim.root.git(),
          actions = {
            ["ctrl-i"] = { fn = goto_circle, desc = "Go to CircleCI" },
            ["alt-i"] = { fn = goto_github, desc = "Go to PR" },
          },
        })
      end,
      desc = "Branches",
    },
  },
  opts = function(_, opts)
    local my_opts = {
      oldfiles = {
        include_current_session = true,
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100,
        },
      },
      grep = {
        rg_glob = true,
        glob_flag = "--iglob",
        glob_separator = "%s%-%-",
      },
    }

    opts = vim.tbl_deep_extend("force", opts, my_opts)
    return opts
  end,
}
