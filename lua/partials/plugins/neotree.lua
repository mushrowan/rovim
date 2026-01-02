return {
	{
		"neo-tree.nvim",
		for_cat = "general",
		cmd = "Neotree",
		keys = {
			{ "<leader>se", desc = "NeoTree" },
		},
		after = function()
			require("neo-tree").setup({

				window = {
					mappings = {
						["<C-["] = "close_window",
					},
				},
				filesystem = {
					window = {
						mappings = {
							["<C-["] = "close_window",
						},
					},
				},
			})

			require("partials.utils").map_all("n", {
				{ "<leader>se", "<cmd>Neotree toggle filesystem<CR>", "NeoTree" },
			})
		end,
	},
}
