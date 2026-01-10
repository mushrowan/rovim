-- SECTION: neocord
-- Discord rich presence integration
return {
	{
		"neocord",
		for_cat = "discordRichPresence",
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
