return {
	{
		"neocord",
		for_cat = "general",
		event = "DeferredUIEnter",
		after = function()
			require("neocord").setup({

				editing_text = "Editing",
				enable_line_number = true,
				reading_text = "Reading",
			})
		end,
	},
}
