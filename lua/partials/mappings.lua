vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("t", "<C-[><C-[>", function()
	vim.cmd("stopinsert")
end, {
	desc = "Exit terminal mode",
})
-- vim.keymap.set("t", "<esc>", "<Nop>", { noremap = true })

require("partials.utils").map_all("n", {
	{ "<C-CR>", "<Esc>jA", "Go to end of next line" },
	{ "<C-q>", function() Snacks.bufdelete() end, "Delete current buffer" },
	-- { "<A-j>", "<C-w>j", "Focus window below" },
	-- { "<A-k>", "<C-w>k", "Focus window above" },
	-- { "<A-h>", "<C-w>h", "Focus window left" },
	-- { "<A-l>", "<C-w>l", "Focus window right" },
	{ "<A-v>", "<C-w>v", "Split vertically" },
	{ "<A-s>", "<C-w>v", "Split horizonally" },
	{ "<A-=>", "<C-w>=", "Resize splits to be equal" },
})
require("partials.utils").map_all("i", {
	{ "<C-CR>", "<Esc>jA", "Go to end of next line" },
})
