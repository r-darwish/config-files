vim.debug_port = 31337
vim.debug_host = "127.0.0.1"

return {
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("uv")
    end,
  },
  {
    "leoluz/nvim-dap-go",
    lazy = true,
    opts = {
      dap_configurations = {
        {
          type = "go",
          name = "Attach port",
          mode = "remote",
          request = "attach",
        },
      },
      delve = {
        port = vim.debug_port,
        host = vim.debug_host,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Out",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Over",
      },
    },
    opts = function(opts)
      local dap = require("dap")
      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-dap",
        name = "lldb",
      }

      dap.configurations.zig = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          cwd = LazyVim.root.get,
          preLaunchTask = "zig build",
          program = function()
            local root = LazyVim.root.get()
            return root .. "/zig-out/bin/" .. vim.fn.fnamemodify(root, ":t")
          end,
          args = {},
        },
      }

      return opts
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
    end,
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            {
              id = "repl",
              size = 1.0,
            },
            -- {
            --   id = "console",
            --   size = 0.5,
            -- },
          },
          position = "bottom",
          size = 10,
        },
      },
    },
  },
}
