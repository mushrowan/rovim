return {
	{
		"auto-session",
		for_cat = "general",
		after = function(_)
			require("auto-session").setup({
				suppressed_dirs = { "~" },
				bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" }, -- or whatever dashboard you use
			})
		end,
	},
}
