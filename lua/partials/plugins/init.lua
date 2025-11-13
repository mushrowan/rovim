require("lze").load({
	{
		"rose-pine",
		lazy = false,
		for_cat = "general",
		after = function()
			require("rose-pine").setup({
				variant = "auto", -- auto, main, moon, or dawn
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"render-markdown.nvim",
		event = "DeferredUIEnter",
		for_cat = "general",
		after = function()
			require("render-markdown").setup({})
		end,
	},

	-- {
	-- 	"markview.nvim",
	-- 	event = "DeferredUIEnter",
	-- 	for_cat = "general",
	--   after = {
	--   }
	-- },
	{
		"lazydev.nvim",
		for_cat = "general",
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
		event = "DeferredUIEnter",
		after = function()
			require("neocord").setup({

				editing_text = "Editing",
				enable_line_number = true,
				reading_text = "Reading",
			})
		end,
	},
	{
		"flash.nvim",
		for_cat = "general",
		event = "DeferredUIEnter",
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
		event = "DeferredUIEnter",
		for_cat = "general",
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("nvim-web-devicons")
		end,
		after = function()
			require("bufferline").setup({})
			require("partials.utils").map_all("n", {
				{
					"<C-l>",
					":bnext<CR>",
					"Next buffer",
				},
				{
					"<C-h>",
					":bprevious<CR>",
					"Previous buffer",
				},
			})
		end,
	},
	{
		"direnv.nvim",
		event = "DeferredUIEnter",
		for_cat = "general",
		after = function()
			require("direnv-nvim").setup({
				async = true,
				on_direnv_finished = function()
					vim.cmd("LspStart")
					if vim.bo.filetype == "rust" then
						require("rustaceanvim.lsp").start()
						require("rustaceanvim.lsp").reload_settings()
					end
				end,
			})
		end,
	},
	{
		"lsp_lines.nvim",
		for_cat = "general",
		event = "DeferredUIEnter",
		after = function()
			vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
			require("lsp_lines").setup()
		end,
	},
	{
		"remote-nvim.nvim",
		for_cat = "general",
		event = "DeferredUIEnter",
		after = function()
			require("remote-nvim").setup({})
		end,
	},
	{
		"telescope.nvim",
		lazy = true,
		on_require = "telescope",
	},
	{
		"bullets.vim",
		ft = "markdown",
	},
	{
		"smart-splits.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("smart-splits").setup({})
			require("partials.utils").map_all("n", {
				{ "<C-A-h>", require("smart-splits").resize_left },
				{ "<C-A-j>", require("smart-splits").resize_down },
				{ "<C-A-k>", require("smart-splits").resize_up },
				{ "<C-A-l>", require("smart-splits").resize_right },
				{ "<A-h>", require("smart-splits").move_cursor_left },
				{ "<A-j>", require("smart-splits").move_cursor_down },
				{ "<A-k>", require("smart-splits").move_cursor_up },
				{ "<A-l>", require("smart-splits").move_cursor_right },
				{ "<A-\\>", require("smart-splits").move_cursor_previous },
				{ "<A-Shift-h>", require("smart-splits").swap_buf_left },
				{ "<A-Shift-j>", require("smart-splits").swap_buf_down },
				{ "<A-Shift-k>", require("smart-splits").swap_buf_up },
				{ "<A-Shift-l>", require("smart-splits").swap_buf_right },
			})
		end,
	},

	{ import = "partials.plugins.noice" },
	{ import = "partials.plugins.mini" },
	{ import = "partials.plugins.treesitter" },
	{ import = "partials.plugins.obsidian" },
	{ import = "partials.plugins.yanky" },
	{ import = "partials.plugins.harpoon" },
	{ import = "partials.plugins.lint" },
	{ import = "partials.plugins.conform" },
	{ import = "partials.plugins.completion" },
	{ import = "partials.plugins.lualine" },
	{ import = "partials.plugins.snacks-nvim" },
	{ import = "partials.plugins.lsp" },
	{ import = "partials.plugins.which-key" },
})
