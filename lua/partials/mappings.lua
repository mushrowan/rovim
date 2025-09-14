vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("t", "<C-[>", function()
	vim.cmd("stopinsert")
end, {
	desc = "Exit terminal mode",
})
