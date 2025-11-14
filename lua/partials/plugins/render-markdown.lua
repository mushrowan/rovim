return {
	{
		"render-markdown.nvim",
		event = "DeferredUIEnter",
		for_cat = "general",
		after = function()
			require("render-markdown").setup({})
		end,
	},
}
