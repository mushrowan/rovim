return {
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
}
