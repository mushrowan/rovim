-- Global keymappings
local utils = require("partials.utils")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Terminal mode
vim.keymap.set("t", "<C-[><C-[>", function()
  vim.cmd("stopinsert")
end, { desc = "Exit terminal mode" })

-- Normal mode
utils.map_all("n", {
  { "<C-CR>", "<Esc>jA", "Go to end of next line" },
  { "<C-q>", function() Snacks.bufdelete() end, "Delete current buffer" },
  { "<A-v>", "<C-w>v", "Split vertically" },
  { "<A-s>", "<C-w>s", "Split horizontally" },
  { "<A-=>", "<C-w>=", "Resize splits to be equal" },
})

-- Insert mode
utils.map_all("i", {
  { "<C-CR>", "<Esc>jA", "Go to end of next line" },
  { "<C-BS>", "<C-w>", "Delete word before cursor" },
})
