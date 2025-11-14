return {
	{
		"remote-nvim.nvim",
		for_cat = "general",
		event = "DeferredUIEnter",
		after = function()
			require("remote-nvim").setup({})
		end,
	},
}
