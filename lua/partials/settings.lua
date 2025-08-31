-- local settings = {}

-- Use the new lua loader
vim.loader.enable()
vim.o.autoindent = true
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 1
vim.o.cursorline = true
vim.o.cursorlineopt = "line"
vim.o.encoding = "utf-8"
vim.o.errorbells = false
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.list = true
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"
vim.o.mouse = "nvi"
vim.o.number = true
vim.o.pumblend = 10
vim.o.relativenumber = true
vim.o.scrolloff = 20
vim.o.shiftwidth = 2
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.undodir = vim.fn.stdpath("state") .. "/undo"
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.visualbell = false
vim.o.winblend = 10
vim.o.wrap = true
vim.o.writebackup = false
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,preview,noselect"

-- [[ Disable auto comment on enter ]]
-- See :help formatoptions
vim.api.nvim_create_autocmd("FileType", {
	desc = "remove formatoptions",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

local function map(mode, key, action, desc)
	vim.keymap.set(mode, key, action, { buffer = 0, noremap = true, silent = true, desc = desc })
end



