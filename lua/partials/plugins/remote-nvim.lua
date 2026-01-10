return {
	{
		"remote-nvim.nvim",
		for_cat = "remote",
		event = "DeferredUIEnter",
		after = function()
			require("remote-nvim").setup({})
		end,
	},
}
