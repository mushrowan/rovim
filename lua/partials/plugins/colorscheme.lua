-- SECTION: colorscheme
-- Eva-02 theme: Red/orange inspired by Evangelion Unit-02
return {
	{
		"rose-pine", -- Fallback colorscheme (kept for reference)
		for_cat = "editor",
		lazy = false,
		priority = 1000,
		after = function()
			-- Use custom Eva-02 colorscheme
			require("partials.eva02").setup()
		end,
	},
}
