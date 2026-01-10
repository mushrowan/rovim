return {
	{
		"render-markdown.nvim",
		event = "DeferredUIEnter",
		for_cat = "notes",
		after = function()
			require("render-markdown").setup({})
		end,
	},
}
