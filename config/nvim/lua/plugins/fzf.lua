local function zoxide()
  require("fzf-lua").fzf_live("zoxide query -l", {
    prompt = false,
    winopts = { title = " Zoxide ", title_pos = "center" },
    actions = {
      ["default"] = function(selected)
        vim.notify(selected[1])
        LazyVim.pick("files", { cwd = selected[1] })()
      end,
      ["ctrl-g"] = function(selected)
        vim.notify(selected[1])
        LazyVim.pick("live_grep", { cwd = selected[1] })()
      end,
    },
  })
end

local function get_tickets(current_file)
  return function()
    local cmd = "get-tickets --raw"
    if current_file then
      cmd = cmd .. " " .. vim.fn.expand("%:p")
    end

    local split = function(t)
      return vim.split(t, " - ")[1]
    end

    require("fzf-lua").fzf_exec(cmd, {
      prompt = false,
      winopts = { title = " Tickets ", title_pos = "center" },
      actions = {
        ["default"] = function(selected)
          vim.fn.setreg("+", split(selected[1]))
        end,
      },
    })
  end
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
    { "<leader>fz", zoxide, { noremap = true, silent = true, desc = "Change directory based on zoxide" } },
    { "<leader>gt", get_tickets(true), { desc = "Get tickets (file)" } },
    { "<leader>gT", get_tickets(false), { desc = "Get tickets" } },
    { "<leader>fp", find_plugin, { desc = "Find plugin" } },
    { "<c-v>", "<cmd>FzfLua registers<cr>", mode = { "i" }, { desc = "Registers" } },
    { "<leader>gC", "<cmd>FzfLua git_bcommits<cr>", { desc = "Buffer commits" } },
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
      {
        desc = "Branches",
      },
    },
  },
  opts = {
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
  },
}
