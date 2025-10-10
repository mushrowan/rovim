require("lze").load({
	{
		"rose-pine",
		for_cat = "general",
		after = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"lazydev.nvim",
		for_cat = "general",
		-- event = "Filetype",
		cmd = { "LazyDev" },
		ft = "lua",
		after = function()
			require("lazydev").setup({
				library = {
					{ words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. "/lua" },
				},
			})
		end,
	},
	{
		"neocord",
		for_cat = "general",
		after = function()
			require("neocord").setup({
				editing_text = "Editing",
				enable_line_number = true,
				reading_text = "Reading",
			})
		end,
	},
	{
		"obsidian.nvim",
		for_cat = "general",
		lazy = true,
		ft = "markdown",
		after = function()
			vim.o.conceallevel = 1
			require("obsidian").setup({
				legacy_commands = false,
				workspaces = {
					{
						name = "colony",
						path = "~/Documents/colony",
					},
				},
			})
		end,
	},
	{
		"flash.nvim",
		for_cat = "general",
		event = { { event = "User", pattern = "DeferredUIEnter" } },
		after = function()
			local flash = require("flash")
			flash.setup({})
			vim.keymap.set({ "n", "x", "o" }, "s", function()
				flash.jump()
			end, { desc = "Flash" })
			vim.keymap.set({ "n", "x", "o" }, "S", function()
				flash.treesitter()
			end, { desc = "Flash Treesitter" })
			vim.keymap.set("o", "r", function()
				flash.remote()
			end, { desc = "Remote Flash" })
			vim.keymap.set({ "o", "x" }, "R", function()
				flash.treesitter_search()
			end, { desc = "Treesitter Search" })
			vim.keymap.set("c", "<c-s>", function()
				flash.toggle()
			end, { desc = "Toggle Flash Search" })
		end,
	},

	{
		"bufferline.nvim",
		for_cat = "general",
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("nvim-web-devicons")
		end,
		after = function()
			require("bufferline").setup({})
			vim.keymap.set("n", "<C-l>", ":bnext<CR>", { desc = "Next Buffer" })
			vim.keymap.set("n", "<C-h>", ":bprevious<CR>", { desc = "Previous Buffer" })
		end,
	},
	{
		"direnv.nvim",
		for_cat = "general",
		after = function()
			require("direnv-nvim").setup({
				async = true,
				on_direnv_finished = function()
					vim.cmd("LspStart")
					if vim.bo.filetype == "rust" then
						require("rustaceanvim.lsp").start()
					end
				end,
			})
		end,
	},
	-- {
	-- 	"nix-develop.nvim",
	-- 	lazy = false,
	-- 	for_cat = "general",
	-- },

	{ import = "partials.plugins.auto-session" },
	{ import = "partials.plugins.treesitter" },
	{ import = "partials.plugins.yanky" },
	{ import = "partials.plugins.harpoon" },
	{ import = "partials.plugins.conform" },
	{ import = "partials.plugins.completion" },
	{ import = "partials.plugins.lualine" },
	{ import = "partials.plugins.snacks-nvim" },
	{ import = "partials.plugins.lsp" },
	{ import = "partials.plugins.which-key" },
})
