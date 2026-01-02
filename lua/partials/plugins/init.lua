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
  { import = "partials.plugins.jinja" },
  { import = "partials.plugins.neotree" },
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
