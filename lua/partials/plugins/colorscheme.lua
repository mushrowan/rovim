-- SECTION: colorscheme
return {
	{
		"rose-pine",
		for_cat = "editor",
		lazy = false,
		priority = 1000,
		after = function()
			local colorschemeName = nixCats("colorscheme")
			vim.cmd.colorscheme(colorschemeName)
		end,
	},
}
