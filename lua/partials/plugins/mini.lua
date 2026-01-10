return {
	{
		"mini.icons",
		for_cat = "general",
		after = function()
			require("mini.icons").setup()
		end,
	},
	{
		"mini.surround",
		for_cat = "general",
		after = function()
			require("mini.surround").setup()
		end,
	},
}
