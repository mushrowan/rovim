return {
	{
		"jinja-vim",
		for_cat = "general",
		ft = "j2",
		after = function()
			require("jinja-nvim").setup({})
		end,
	},
}
