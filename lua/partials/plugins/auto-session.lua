return {
	{
		"auto-session",
		for_cat = "general",
		after = function(_)
			require("auto-session").setup({
				suppressed_dirs = { "~" },
			})
		end,
	},
}
