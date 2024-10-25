return {
  {
    "jake-stewart/multicursor.nvim",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      set({ "n", "v" }, "<leader>ma", mc.matchAllAddCursors, { desc = "Add cursors to all matches" })

      set({ "n", "v" }, "<C-A-n>", mc.nextCursor, { desc = "Move to next cursor" })
      set({ "n", "v" }, "<C-A-p>", mc.prevCursor, { desc = "Move to previous cursor" })

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
    keys = {
      {
        "<C-p>",
        function()
          require("mc").matchAddCursor(-1)
        end,
      },
      {
        "<C-n>",
        function()
          require("mc").matchAddCursor(1)
        end,
      },
      {
        "<C-up>",
        function()
          require("mc").lineAddCursor(-1)
        end,
      },
      {
        "<C-down>",
        function()
          require("mc").lineAddCursor(1)
        end,
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
