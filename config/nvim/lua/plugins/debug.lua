return {
  { import = "lazyvim.plugins.extras.dap.core" },
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