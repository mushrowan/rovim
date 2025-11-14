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
		"bullets.vim",
		ft = "markdown",
	},

	{ import = "partials.plugins.bufferline" },
	{ import = "partials.plugins.completion" },
	{ import = "partials.plugins.conform" },
	{ import = "partials.plugins.direnv" },
	{ import = "partials.plugins.harpoon" },
	{ import = "partials.plugins.lint" },
	{ import = "partials.plugins.lsp" },
	{ import = "partials.plugins.lsp_lines" },
	{ import = "partials.plugins.lualine" },
	{ import = "partials.plugins.mini" },
	{ import = "partials.plugins.neocord" },
	{ import = "partials.plugins.noice" },
	{ import = "partials.plugins.obsidian" },
	{ import = "partials.plugins.remote-nvim" },
	{ import = "partials.plugins.render-markdown" },
	{ import = "partials.plugins.smart-splits" },
	{ import = "partials.plugins.snacks-nvim" },
	{ import = "partials.plugins.telescope" },
	{ import = "partials.plugins.treesitter" },
	{ import = "partials.plugins.which-key" },
	{ import = "partials.plugins.yanky" },
})
