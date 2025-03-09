return {
  {
    "jake-stewart/multicursor.nvim",
    config = true,
    priority = 1000,
    keys = {
      {
        "<C-p>",
        function()
          require("multicursor-nvim").matchAddCursor(-1)
        end,
        mode = { "n", "v" },
      },
      {
        "<C-n>",
        function()
          require("multicursor-nvim").matchAddCursor(1)
        end,
        mode = { "n", "v" },
      },
      {
        "<A-k>",
        function()
          require("multicursor-nvim").lineAddCursor(-1)
        end,
        mode = { "n", "v" },
      },
      {
        "<A-j>",
        function()
          require("multicursor-nvim").lineAddCursor(1)
        end,
        mode = { "n", "v" },
      },
      {
        "<leader>ma",
        function()
          require("multicursor-nvim").matchAllAddCursors()
          if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
          end
        end,
        desc = "Add cursors to all matches",
        mode = { "n", "v" },
      },
      {
        "<C-A-n>",
        function()
          require("multicursor-nvim").nextCursor()
        end,
        desc = "Move to next cursor",
        mode = { "n", "v" },
      },
      {
        "<C-A-p>",
        function()
          require("multicursor-nvim").prevCursor()
        end,
        desc = "Move to previous cursor",
        mode = { "n", "v" },
      },
      {
        "<A-d>",
        function()
          require("multicursor-nvim").deleteCursor()
        end,
        mode = { "n", "v" },
        desc = "Delete cursor",
      },
      {
        "<leader>ml",
        function()
          require("multicursor-nvim").alignCursors()
        end,
        mode = { "n", "v" },
        desc = "Align the cursors",
      },
      {
        "<leader>mx",
        function()
          require("multicursor-nvim").clearCursors()
        end,
        mode = { "n", "v" },
        desc = "Clear all cursors",
      },
      {
        "<A-m>",
        function()
          require("multicursor-nvim").toggleCursor()
        end,
        mode = { "n", "v" },
        desc = "Toggle a cursor",
      },
      {
        "<leader>mm",
        function()
          require("multicursor-nvim").enableCursors()
        end,
        mode = { "n", "v" },
        desc = "Enable cursors",
      },
      {
        "<leader>mr",
        function()
          require("multicursor-nvim").restoreCursors()
        end,
        mode = { "n" },
      },

      {
        "<c-leftmouse>",
        function()
          require("multicursor-nvim").handleMouse()
        end,
        mode = "n",
      },

      {
        "<C-m>",
        function()
          require("multicursor-nvim").splitCursors()
        end,
        mode = "v",
      },
      {
        "I",
        function()
          require("multicursor-nvim").insertVisual()
        end,
        mode = "v",
      },
      {
        "A",
        function()
          require("multicursor-nvim").appendVisual()
        end,
        mode = "v",
      },
      {
        "M",
        function()
          require("multicursor-nvim").matchCursors()
        end,
        mode = "v",
      },
      {
        "<c-i>",
        function()
          require("multicursor-nvim").jumpForward()
        end,
        mode = { "v", "n" },
      },
      {
        "<c-o>",
        function()
          require("multicursor-nvim").jumpBackward()
        end,
        mode = { "v", "n" },
      },
    },
  },
}
