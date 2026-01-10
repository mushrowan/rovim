-- SECTION: mini
-- Minimal utility plugins from mini.nvim collection
return {
	{
		"mini.icons",
		for_cat = "editor",
		after = function()
			-- Provides icon glyphs used by other plugins
			require("mini.icons").setup()
		end,
	},
	{
		"mini.surround",
		for_cat = "editor",
		after = function()
			-- Surround text objects: sa (add), sd (delete), sr (replace)
			require("mini.surround").setup()
		end,
	},
}
