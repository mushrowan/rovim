-- SECTION: which-key
-- Displays pending keybinds in popup
return {
  {
    "which-key.nvim",
    for_cat = "editor",
    event = "DeferredUIEnter",
    after = function()
      local wk = require("which-key")
      wk.setup({
        notify = true,
        preset = "modern",
        replace = {
          ["<cr>"] = "RETURN",
          ["<leader>"] = "SPACE",
          ["<space>"] = "SPACE",
          ["<tab>"] = "TAB",
        },
        win = { border = "rounded" },
      })

      -- Register key group labels
      wk.add({
        { "<leader>a", desc = "+Actions/Session" },
        { "<leader>c", desc = "+Code" },
        { "<leader>d", desc = "+Direnv" },
        { "<leader>g", desc = "+Git" },
        { "<leader>gh", desc = "+Hunks" },
        { "<leader>gt", desc = "+Toggle" },
        { "<leader>l", desc = "+LSP" },
        { "<leader>lg", desc = "+Go to" },
        { "<leader>lw", desc = "+Workspace" },
        { "<leader>N", desc = "+Notifications" },
        { "<leader>o", desc = "+Obsidian" },
        { "<leader>q", desc = "+Quickfix" },
        { "<leader>r", desc = "+Rename" },
        { "<leader>s", desc = "+Search/Pick" },
        { "<leader>t", desc = "+Tabs" },
        { "<leader>tm", desc = "+Move" },
        { "<leader>T", desc = "+Test" },
        { "<leader>v", desc = "+View" },
      })
    end,
  },
}
