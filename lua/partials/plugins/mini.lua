return {
	{
		"mini.icons",
		for_cat = "editor",
		after = function()
			require("mini.icons").setup()
		end,
	},
	{
		"mini.surround",
		for_cat = "editor",
		after = function()
			require("mini.surround").setup()
		end,
	},
}
