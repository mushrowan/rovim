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
vim.o.writebackup = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,preview,noselect"
-- suggested by autosession
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- [[ Disable auto comment on enter ]]
-- See :help formatoptions
vim.api.nvim_create_autocmd("FileType", {
	desc = "remove formatoptions",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})
-- -- Set up a global autocommand to restart LSP after direnv loads.
-- vim.api.nvim_create_autocmd("User", {
--     pattern = { "DirenvReady" },
--     callback = function()
--         -- Only restart if the current file is a Rust file.
--         if vim.bo.filetype == "rust" then
--             require("rustaceanvim.lsp").restart()
--         end
--     end,
-- })
-- Neovide settings
vim.g.neovide_normal_opacity = 0.95
vim.g.neovide_cursor_vfx_mode = "pixiedust"

-- Neovide binds
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
	change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
	change_scale_factor(1 / 1.25)
end)
