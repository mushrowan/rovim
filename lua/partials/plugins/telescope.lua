return {
	{
		"telescope.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = "previous_item",
							["<C-j>"] = "next_item",
						},
					},
				},
			})
		end,
	},
}
