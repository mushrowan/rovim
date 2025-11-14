return {
	{
		"telescope.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = "move_selection_previous",
							["<C-j>"] = "move_selection_next",
						},
					},
				},
			})
		end,
	},
}
