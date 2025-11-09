vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("t", "<C-[><C-[>", function()
	vim.cmd("stopinsert")
end, {
	desc = "Exit terminal mode",
})
-- vim.keymap.set("t", "<esc>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<C-q>", "<cmd>bd<CR>", { desc = "Delete current buffer", silent = true })
vim.keymap.set("i", "<C-CR>", "<C-o>j<C-o>$", { desc = "Go to end of next line", silent = true })
