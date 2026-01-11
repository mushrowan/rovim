-- SECTION: mini
-- Minimal utility plugins from mini.nvim collection
return {
	{
		"mini.icons",
		for_cat = "editor",
		dep_of = { "tabby.nvim", "lualine.nvim", "snacks.nvim" },
		after = function()
			-- Provides icon glyphs used by other plugins
			require("mini.icons").setup()
		end,
	},
	{
		"mini.surround",
		for_cat = "editor",
		keys = {
			{ "sa", mode = { "n", "v" }, desc = "Add surrounding" },
			{ "sd", desc = "Delete surrounding" },
			{ "sr", desc = "Replace surrounding" },
			{ "sf", desc = "Find surrounding" },
			{ "sF", desc = "Find surrounding (left)" },
			{ "sh", desc = "Highlight surrounding" },
			{ "sn", desc = "Update n_lines" },
		},
		after = function()
			-- Surround text objects: sa (add), sd (delete), sr (replace)
			require("mini.surround").setup()
		end,
	},
}
