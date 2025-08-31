return {
	{
		"blink.cmp",
		for_cat = "general.completion",
		after = function(_)
			require("blink.cmp").setup({})
		end,
	},
}
