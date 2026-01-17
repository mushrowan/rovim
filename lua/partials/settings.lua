-- Core vim settings
vim.loader.enable()

-- Editing
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- Search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"

-- Display
vim.o.cursorline = true
vim.o.cursorlineopt = "line"
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.scrolloff = 20
vim.o.wrap = true
vim.o.linebreak = true
vim.o.list = true
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"
vim.o.conceallevel = 1

-- Windows
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.pumblend = 10
vim.o.winblend = 10

-- Behavior
vim.o.clipboard = "unnamedplus"
vim.o.hidden = true
vim.o.mouse = "nvi"
vim.o.timeoutlen = 300
vim.o.updatetime = 250
vim.o.completeopt = "menu,preview,noselect"

-- Files
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = true
vim.o.undodir = vim.fn.stdpath("state") .. "/undo"
vim.o.undofile = true
vim.o.encoding = "utf-8"

-- UI feedback
vim.o.cmdheight = 1
vim.o.errorbells = false
vim.o.visualbell = false

-- Diagnostics
vim.diagnostic.config({
  signs = true,
  underline = true,
})
