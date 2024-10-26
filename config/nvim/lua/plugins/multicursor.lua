return {
  {
    "jake-stewart/multicursor.nvim",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      set({ "n", "v" }, "<A-d>", mc.deleteCursor, { desc = "Delete cursor" })
      set({ "n", "v" }, "<leader>mx", mc.clearCursors, { desc = "Clear all cursors" })
      set({ "n", "v" }, "<A-m>", mc.toggleCursor, { desc = "Toggle a cursor" })
      set({ "n", "v" }, "<leader>mm", mc.enableCursors, { desc = "Enable cursors" })
      set("n", "<leader>mr", mc.restoreCursors)

      set("n", "<c-leftmouse>", mc.handleMouse)

      set("v", "<C-m>", mc.splitCursors)
      set("v", "I", mc.insertVisual)
      set("v", "A", mc.appendVisual)
      set("v", "M", mc.matchCursors)

      set({ "v", "n" }, "<c-i>", mc.jumpForward)
      set({ "v", "n" }, "<c-o>", mc.jumpBackward)
    end,
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
        "<C-up>",
        function()
          require("multicursor-nvim").lineAddCursor(-1)
        end,
        mode = { "n", "v" },
      },
      {
        "<C-down>",
        function()
          require("multicursor-nvim").lineAddCursor(1)
        end,
        mode = { "n", "v" },
      },
      {
        "<leader>ma",
        function()
          require("multicursor-nvim").matchAllAddCursors()
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
        "<esc>",
        function()
          local mc = require("multicursor-nvim")
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          elseif mc.hasCursors() then
            mc.clearCursors()
          else
            -- Default <esc> handler.
          end
        end,
      },
    },
  },
}
