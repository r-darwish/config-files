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
        mode = { "n", "x" },
      },
      {
        "<C-n>",
        function()
          require("multicursor-nvim").matchAddCursor(1)
        end,
        mode = { "n", "x" },
      },
      {
        "<A-k>",
        function()
          require("multicursor-nvim").lineAddCursor(-1)
        end,
        mode = { "n", "x" },
      },
      {
        "<A-j>",
        function()
          require("multicursor-nvim").lineAddCursor(1)
        end,
        mode = { "n", "x" },
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
        mode = { "n", "x" },
      },
      {
        "<C-A-n>",
        function()
          require("multicursor-nvim").nextCursor()
        end,
        desc = "Move to next cursor",
        mode = { "n", "x" },
      },
      {
        "<C-A-p>",
        function()
          require("multicursor-nvim").prevCursor()
        end,
        desc = "Move to previous cursor",
        mode = { "n", "x" },
      },
      {
        "<A-d>",
        function()
          require("multicursor-nvim").deleteCursor()
        end,
        mode = { "n", "x" },
        desc = "Delete cursor",
      },
      {
        "<leader>ml",
        function()
          require("multicursor-nvim").alignCursors()
        end,
        mode = { "n", "x" },
        desc = "Align the cursors",
      },
      {
        "<leader>mx",
        function()
          require("multicursor-nvim").clearCursors()
        end,
        mode = { "n", "x" },
        desc = "Clear all cursors",
      },
      {
        "<A-m>",
        function()
          require("multicursor-nvim").toggleCursor()
        end,
        mode = { "n", "x" },
        desc = "Toggle a cursor",
      },
      {
        "<leader>mm",
        function()
          require("multicursor-nvim").enableCursors()
        end,
        mode = { "n", "x" },
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
        mode = "x",
      },
      {
        "I",
        function()
          require("multicursor-nvim").insertVisual()
        end,
        mode = "x",
      },
      {
        "A",
        function()
          require("multicursor-nvim").appendVisual()
        end,
        mode = "x",
      },
      {
        "M",
        function()
          require("multicursor-nvim").matchCursors()
        end,
        mode = "x",
      },
      {
        "<c-i>",
        function()
          require("multicursor-nvim").jumpForward()
        end,
        mode = { "x", "n" },
      },
      {
        "<c-o>",
        function()
          require("multicursor-nvim").jumpBackward()
        end,
        mode = { "x", "n" },
      },
    },
  },
}
