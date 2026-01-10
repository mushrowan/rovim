-- SECTION: lazydev
-- Lua development support with nixCats integration
return {
	{
		"lazydev.nvim",
		for_cat = "lsp",
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
}
